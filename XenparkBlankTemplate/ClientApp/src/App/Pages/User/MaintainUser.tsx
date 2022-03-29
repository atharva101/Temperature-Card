import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Form, Button, Alert, Spinner } from 'react-bootstrap';
import { connect, useDispatch } from 'react-redux';
import { useHistory } from 'react-router';
import { IMaster, IRoomMaster } from '../../../models/master';
import { IRole } from '../../../models/role';
import { IUser, IUserRoom } from '../../../models/user';
import { RootState } from '../../../store/action-types';
import { fetchRoomMasterData, redirect } from '../../../store/master/master.action';
import { fetchAllRoles } from '../../../store/role/role.action';


import { saveUser, selectUser, UserState } from '../../../store/user/user.action';

interface IMaintainUserProps {
    users: UserState;
    roles: IRole[];
    roomMaster: IRoomMaster[],
}
const MaintainUser = (props: IMaintainUserProps) => {
    const [errors, setErrors] = useState([] as string[]);
    const [isEdit, setIsEdit] = useState(false);

    const [user, setUser] = useState({} as IUser);
    const [roomMaster, setRoomMasters] = useState(props.roomMaster);
    const [userRooms, setUserRooms] = useState([] as IUserRoom[]);

    const [plantId, setPlantId] = useState(-1);
    const [blockId, setBlockId] = useState(-1);
    const [areaList, setAreaList] = useState([] as IMaster[]);
    const [checkedAreaList, setCheckedAreaList] = useState([] as number[]);

    const history = useHistory();
    const dispatch = useDispatch();

    useEffect(() => {
        dispatch(fetchAllRoles(true));
        dispatch(fetchRoomMasterData());
    }, []);

    useEffect(() => {
        if (props.users.selectedUserId > 0) {
            setIsEdit(true);
            const tempUser = props.users.users.find(x => x.Id === props.users.selectedUserId);
            if (tempUser) {
                setUser(JSON.parse(JSON.stringify(tempUser)));
                if (tempUser.UserRooms) {
                    setUserRooms(JSON.parse(JSON.stringify(tempUser.UserRooms)))

                }
            }
        }
        else setIsEdit(false);
    }, [props.users.selectedUserId, JSON.stringify(props.users.users)]);

    useEffect(() => {
        setRoomMasters(props.roomMaster);
    }, [props.roomMaster]);

    useEffect(() => {
        if (userRooms && userRooms.length > 0 && roomMaster && roomMaster.length > 0) {
            let defaultAreaId: number[] = [];
            userRooms.forEach(room => {
                const area = roomMaster.find(x => x.RoomId === room.RoomId);
                if (area) {
                    const areaRooms = roomMaster.filter(x => x.AreaId === area?.AreaId).map(x => x.RoomId);
                    let allRoomsExists = true;
                    areaRooms.forEach(element => {
                        if (userRooms.findIndex(x => x.RoomId === element) < 0) {
                            allRoomsExists = false;
                        }
                    });
                    if (allRoomsExists) {
                        defaultAreaId.push(area.AreaId);
                    }
                }
            });
            if (defaultAreaId.length > 0) {
                setCheckedAreaList(defaultAreaId);
            }
            const temp = roomMaster.find(x => x.RoomId === userRooms[0].RoomId);
            if (temp) {
                setPlantId(temp.PlantId);
                setBlockId(temp.BlockId);
            }

        }
    }, [JSON.stringify(userRooms), JSON.stringify(roomMaster)]);

    useEffect(() => {
        console.log(user);
    }, [user]);

    useEffect(() => {
        if (props.users.status === 'saved')
            dispatch(redirect(history, '/user'));
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [props.users.status]);

    const hasError = (key: string) => {
        return errors.indexOf(key) !== -1;
    }
    const handleSubmit = () => {
        let objError = [] as string[];
        if (!user.FirstName || user.FirstName.length < 1) {
            objError.push('FirstName');
        }
        if (!user.LastName || user.LastName.length < 1) {
            objError.push('LastName');
        }
        if (!user.Email || user.Email.length < 1) {
            objError.push('Email');
        }
        if (!user.UserName || user.UserName.length < 1) {
            objError.push('Username');
        }
        if (!user.RoleId || user.RoleId < 1) {
            objError.push('RoleId');
        }
        if (plantId < 1) {
            objError.push('PlantId');
        }
        if (blockId < 1) {
            objError.push('BlockId');
        }

        setErrors(objError);

        if (objError.length === 0) {
            const tempUser = user;
            if (userRooms) tempUser.UserRooms = userRooms;
            dispatch(saveUser(tempUser));
        }

    };

    const handleInputChanges = (e: React.ChangeEvent<HTMLInputElement>) => {
        e.preventDefault();
        const { name, value } = e.target;
        setUser({
            ...user,
            [name]: value,
        });

    }
    const handleSelectChanges = (e: any) => {
        e.preventDefault();
        const { name, value } = e.target;
        if (name == 'plant') {
            setPlantId(parseInt(value));
        }
        else if (name == 'block') {
            setBlockId(parseInt(value));
        }
        setUser({
            ...user,
            [name]: value,
        });
    }

    const handleCheckboxChange = (e: any) => {
        const { name, value } = e.target;
        if (name.indexOf('area') >= 0) {
            //Deepak Area Checked
            const tempAreaIndex = checkedAreaList.findIndex(x => x === parseInt(value));
            let tempCheckedAreaList: number[] = [];
            if (e.target.checked == true) {
                if (tempAreaIndex < 0) {
                    // add area to checked area list  
                    tempCheckedAreaList = [...checkedAreaList, parseInt(value)]
                    setCheckedAreaList(tempCheckedAreaList);
                }
            } else {
                //remove area from checkedAreaList
                if (tempAreaIndex >= 0) {
                    tempCheckedAreaList = checkedAreaList.filter(x => x !== parseInt(value));
                    setCheckedAreaList(tempCheckedAreaList);
                }
            }
            //SET ROOMS
            let tempUserRooms = userRooms as IUserRoom[];
            tempCheckedAreaList.forEach(areaId => {
                roomMaster.filter(x => x.PlantId === plantId && x.BlockId === blockId && x.AreaId === areaId).forEach(room => {
                    if (userRooms.findIndex(x => x.RoomId === room.RoomId) < 0) {
                        tempUserRooms = [...tempUserRooms, { Id: 0, RoomId: room.RoomId, UserId: user.Id }];
                    }
                });
            });
            setUserRooms(tempUserRooms);
        }
        else if (name.indexOf('room') >= 0) {
            const tempRoomIndex = userRooms.findIndex(x => x.RoomId === parseInt(value));

            if (e.target.checked == true) {
                if (tempRoomIndex < 0) {
                    // add room to UserRoom list
                    setUserRooms([...userRooms, { Id: 0, UserId: user.Id, RoomId: parseInt(value) }]);

                }
            } else {
                //remove area from checkedAreaList
                if (tempRoomIndex >= 0) {
                    setUserRooms(userRooms.filter(x => x.RoomId !== parseInt(value)));
                }
                //Remove Area Id from CheckedAreaList
                const tempArea = roomMaster.find(x => x.RoomId === parseInt(value));
                if (tempArea) {
                    setCheckedAreaList(checkedAreaList.filter(x => x !== tempArea.AreaId));
                }
            }
        }
    }

    useEffect(() => {
        const temp = roomMaster.filter(x => x.PlantId === plantId && x.BlockId === blockId);
        const tmpAreaList: IMaster[] = [];
        temp.forEach(element => {
            if (tmpAreaList.findIndex(x => x.Id === element.AreaId) < 0) {
                tmpAreaList.push({ Id: element.AreaId, Code: element.AreaCode, Description: element.AreaDescription } as IMaster);
            }
        });
        setAreaList(tmpAreaList);
    }, [blockId, plantId]);

    // useEffect(() => {
    //     let tempUserRooms = userRooms as IUserRoom[];
    //     checkedAreaList.forEach(areaId => {
    //         roomMaster.filter(x => x.PlantId === plantId && x.BlockId === blockId && x.AreaId === areaId).forEach(room => {
    //             if (userRooms.findIndex(x => x.RoomId === room.RoomId) < 0) {
    //                 tempUserRooms = [...tempUserRooms, { Id: 0, RoomId: room.RoomId, UserId: user.Id }];
    //             }
    //         });
    //     });
    //     setUserRooms(tempUserRooms);
    // }, [checkedAreaList]);


    const redirectToUserList = () => {
        dispatch(selectUser(-1));
        history.push('/user');
    }
    return (<>
        <Row>
            <Col>
                <Card>
                    <Card.Header>
                        <Card.Title as="h5"><i className="feather icon-arrow-left p-r-5" onClick={() => redirectToUserList()} /> {isEdit ? 'Edit User' : 'Add User'}</Card.Title>
                    </Card.Header>
                    <Card.Body>
                        {
                            props.users.error && props.users.error.length > 0
                                ?
                                <Alert variant="danger">
                                    Something went wrong! Please relaod the page.
                                </Alert>
                                : null
                        }
                        {
                            props.users.status === 'inprogress'
                                ?
                                <Spinner animation="border" variant="primary" />
                                :
                                <Form noValidate >
                                    <Form.Row>
                                        <Form.Group as={Col} md="6" >
                                            <Form.Label>First name</Form.Label>
                                            <Form.Control
                                                required
                                                type="text"
                                                placeholder="First name"
                                                name="FirstName"
                                                defaultValue={user.FirstName}
                                                onChange={handleInputChanges}
                                                className={hasError("FirstName") ? "is-invalid" : ""}
                                            />
                                            <div className={hasError("FirstName") ? "invalid-feedback" : "hidden"}>
                                                Required Field
                                            </div>
                                        </Form.Group>
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Last name</Form.Label>
                                            <Form.Control
                                                required
                                                type="text"
                                                placeholder="Last name"
                                                name="LastName"
                                                defaultValue={user.LastName}
                                                onChange={handleInputChanges}
                                                className={hasError("LastName") ? "is-invalid" : ""}
                                            />
                                            <div className={hasError("LastName") ? "invalid-feedback" : "hidden"}>
                                                Required Field
                                            </div>
                                        </Form.Group>
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Email</Form.Label>
                                            <Form.Control type="text" placeholder="Email" name="Email" required
                                                defaultValue={user.Email}
                                                onChange={handleInputChanges}
                                                className={hasError("Email") ? "is-invalid" : ""}
                                            />
                                            <div className={hasError("Email") ? "invalid-feedback" : "hidden"}>
                                                Required Field
                                            </div>
                                        </Form.Group>
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Username</Form.Label>
                                            <Form.Control
                                                type="text"
                                                placeholder="Username"
                                                name="UserName"
                                                required
                                                defaultValue={user.UserName}
                                                onChange={handleInputChanges}
                                                className={hasError("Username") ? "is-invalid" : ""}
                                            />
                                            <div className={hasError("Username") ? "invalid-feedback" : "hidden"}>
                                                Required Field
                                            </div>
                                        </Form.Group>
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Role</Form.Label>
                                            <select value={user.RoleId ?? -1} name="RoleId"
                                                onChange={handleSelectChanges}
                                                className={hasError("RoleId") ? "form-control is-invalid" : "form-control"}
                                            >
                                                <option value="">--Select--</option>
                                                {
                                                    props.roles && props.roles.map((x, i) => {
                                                        return <option key={i} value={x.Id}>
                                                            {x.Name}
                                                        </option>
                                                    })
                                                }

                                            </select>
                                            <div className={hasError("RoleId") ? "invalid-feedback" : "hidden"}>
                                                Required Field
                                            </div>
                                        </Form.Group>
                                    </Form.Row>
                                    <Form.Row>
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Plant</Form.Label>
                                            <select name="plant" value={plantId}
                                                onChange={handleSelectChanges}
                                                className={hasError("PlantId") ? "form-control is-invalid" : "form-control"}
                                            >
                                                <option>Select</option>
                                                {
                                                    roomMaster
                                                        .map((x: IRoomMaster) => x.PlantId)
                                                        .filter((x, i: number, a) => a.indexOf(x) === i) //get Distinct
                                                        .map((x, i) => {
                                                            return <option key={i} value={x}>
                                                                {
                                                                    roomMaster.filter(p => p.PlantId === x)[0].PlantName
                                                                }
                                                            </option>
                                                        })
                                                }
                                            </select>
                                            <div className={hasError("PlantId") ? "invalid-feedback" : "hidden"}>
                                                Required Field
                                            </div>
                                        </Form.Group>
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Block</Form.Label>
                                            <select name="block" value={blockId}
                                                onChange={handleSelectChanges}
                                                className={hasError("BlockId") ? "form-control is-invalid" : "form-control"}
                                            >
                                                <option>Select</option>
                                                {
                                                    roomMaster.filter(x => x.PlantId == plantId)
                                                        .map((x: IRoomMaster) => x.BlockId)
                                                        .filter((x, i: number, a) => a.indexOf(x) === i) //get Distinct
                                                        .map((x, i) => {
                                                            return <option key={i} value={x}>
                                                                {
                                                                    roomMaster.filter(p => p.BlockId === x)[0].BlockDescription
                                                                }
                                                            </option>
                                                        })
                                                }
                                            </select>
                                            <div className={hasError("BlockId") ? "invalid-feedback" : "hidden"}>
                                                Required Field
                                            </div>
                                        </Form.Group>
                                    </Form.Row>

                                    {

                                        areaList && areaList.map((area, i) => {

                                            return <>
                                                <Form.Row>
                                                    <Form.Group as={Col} md="6" ><Form.Label style={{ fontWeight: "bold" }}>Area</Form.Label></Form.Group>
                                                </Form.Row>
                                                <Form.Row>
                                                    <Form.Group as={Col} md="12" >
                                                        <Form.Check
                                                            style={{ fontWeight: "bold" }}
                                                            inline
                                                            key={area.Id}
                                                            type='checkbox'
                                                            name={'area' + i}
                                                            id={`chk-${area.Id}`}
                                                            checked={checkedAreaList.findIndex(x => x === area.Id) >= 0 ? true : false}
                                                            label={area.Description}
                                                            onChange={handleCheckboxChange}
                                                            value={area.Id}
                                                        />
                                                    </Form.Group>
                                                </Form.Row>
                                                <Form.Row style={{ paddingLeft: "25px" }}>
                                                    {
                                                        roomMaster &&
                                                        roomMaster.filter(x => x.PlantId === plantId && x.BlockId === blockId && x.AreaId === area.Id)
                                                            .map((room, roomIndex) => {
                                                                return <Form.Group as={Col} md="4" key={i.toString() + roomIndex.toString()}>
                                                                    <Form.Check
                                                                        inline
                                                                        key={room.RoomId}
                                                                        type='checkbox'
                                                                        id={`chk-${room.RoomId}`}
                                                                        name={`room-${room.RoomId}`}
                                                                        label={room.RoomDescription}
                                                                        onChange={handleCheckboxChange}
                                                                        value={room.RoomId}
                                                                        checked={userRooms.findIndex(x => x.RoomId === room.RoomId) >= 0 ? true : false}
                                                                    />
                                                                </Form.Group>
                                                            })
                                                    }
                                                </Form.Row>
                                            </>
                                        })


                                    }

                                    <Button variant="primary" className="btn-sm btn-round has-ripple"
                                        onClick={() => handleSubmit()}>
                                        Submit
                                    </Button>
                                </Form>
                        }
                    </Card.Body>
                </Card>
            </Col>
        </Row>

    </>);
};
const mapStateToProps = (state: RootState) => ({
    users: state.userState as UserState,
    roles: state.roleState.roles as IRole[],
    roomMaster: state.masterState.master as IRoomMaster[],
});

export default connect(mapStateToProps)(MaintainUser)
