import React, { useEffect, useState } from 'react';
import { Row, Col, Card, Alert, Table, Dropdown } from 'react-bootstrap';
import { FullScreen, useFullScreenHandle } from "react-full-screen";
import { IRoom, RoomLog } from '../../../models/room';
import { RootState } from '../../../store/action-types';
import { RoomState, changeRoomStatus, fetchAllRooms, selectRoom, fetchRoomByDeviceIP } from '../../../store/rooms/room.action';
import { connect, useDispatch } from 'react-redux';
import { HubConnection, HubConnectionBuilder } from "@microsoft/signalr";
import { IPermission } from '../../../models/role';
import mylanLogod from '../../../assets/images/mylan.png';

interface IRoomDashboardProps {
    rooms: RoomState;
    changeRoomStatus: any;
    fetchAllRooms: any;
    permissions: IPermission[];
    fetchRoomByDeviceIP: any;
    loggedInUser: any;

}
const RoomDashboard = (props: IRoomDashboardProps) => {
    const fullScreenHandle = useFullScreenHandle();
    const [isFullScreen, setFullScreen] = useState(false);
    const [status, setStatus] = useState('');

    const [currentWorkflowState, setCurrentWorkflowState] = useState({} as RoomLog);
    const [connection, setConnection] = useState<null | HubConnection>(null);

    const [canAssignBatchToRoom, setCanAssignBatchToRoom] = useState(false);
    const [canChangeBatchStatus, setCanChangeBatchStatus] = useState(false);

    const [canChangStatusNoActivity, setCanChangStatusNoActivity] = useState(false);
    const [canChangStatusProduction, setCanChangStatusProduction] = useState(false);
    const [canChangStatusCleaning, setCanChangStatusCleaning] = useState(false);
    const [canChangStatusMaintainance, setCanChangStatusMaintainance] = useState(false);



    const [roomId, setRoomId] = useState(0);
    const dispatch = useDispatch();
    useEffect(() => {
        if (props.permissions && props.permissions.length > 0) {
            setCanAssignBatchToRoom(props.permissions.filter(x => x.PermissionName === 'Assign Batch to Room').length > 0 ? true : false);
            setCanChangeBatchStatus(props.permissions.filter(x => x.PermissionName === 'Change Batch Status').length > 0 ? true : false);
            setCanChangStatusNoActivity(props.permissions.filter(x => x.PermissionName === 'No Activity').length > 0 ? true : false);
            setCanChangStatusProduction(props.permissions.filter(x => x.PermissionName === 'Production').length > 0 ? true : false);
            setCanChangStatusCleaning(props.permissions.filter(x => x.PermissionName === 'Cleaning').length > 0 ? true : false);
            setCanChangStatusMaintainance(props.permissions.filter(x => x.PermissionName === 'Maintenance').length > 0 ? true : false);
        }
    }, [props.permissions]);

    useEffect(() => {
        if (props.loggedInUser.RoleId == -1) {
            
            const interval = setInterval(() => {
                dispatch(fetchRoomByDeviceIP())
                console.log('This will be called every 5 seconds');
            }, 10000);
            
            return () => clearInterval(interval);
        }
    }, [])

    useEffect(() => {
        if (props.rooms.status == 'done') {
            const tempRoom = props.rooms.rooms[0];
            if (tempRoom) {
                setRoom(tempRoom);
                console.log(tempRoom)

            }
        };
    }, [props.rooms.status]);

    const enterFullScreen = () => {
        setFullScreen(true);
        fullScreenHandle.enter();
    };
    const exitFullScreen = () => {
        setFullScreen(false);
        fullScreenHandle.exit();
    };

    const [room, setRoom] = useState({} as IRoom);
    useEffect(() => {
        if (props.rooms.selectedRoomId > 0) {
            const tempRoom = props.rooms.rooms.find(x => x.RoomId === props.rooms.selectedRoomId);
            if (tempRoom) {
                setRoom(tempRoom);
            }
        };
    }, [props.rooms.selectedRoomId, props.rooms.rooms]);

    useEffect(() => {
        if (room && room.RoomLogs && room.RoomLogs.length > 0) {
            const currentIndex = room.RoomLogs.filter(x => x.IsCurrent === true);
            if (currentIndex.length > 0)
                setCurrentWorkflowState(currentIndex[0]);
        }
    }, [room]);

    useEffect(() => {
        const connect = new HubConnectionBuilder()
            .withUrl("/signalServer")
            .withAutomaticReconnect()
            .build();

        setConnection(connect);
    }, []);

    useEffect(() => {
        if (connection) {
            connection
                .start()
                .then(() => {
                    connection.on("ReceiveMessage", (message: any) => {
                        //TODO FetchData
                        props.fetchAllRooms();
                    });
                })
                .catch((error: Error) => {

                });
        }
    }, [connection]);

    const changeStatus = async (log: RoomLog) => {
        if ((log.RoomStatus == 'No Activity' && canChangStatusNoActivity) ||
            (log.RoomStatus == 'Production' && canChangStatusProduction) ||
            (log.RoomStatus == 'Cleaning' && canChangStatusCleaning) ||
            (log.RoomStatus == 'Maintenance' && canChangStatusMaintainance)) {
            await Promise.all([
                props.changeRoomStatus(room.RoomId, room.BatchId, room.BatchSize, room.UOM, log.RoomStatusId, props.loggedInUser.Id)
            ]).then(async () => { if (connection) await connection.send("SendMessage", "RoomStatusChanged") });
        }
    }
    return (<>
        <FullScreen handle={fullScreenHandle}>
            <Row>
                <Col xl={12} md={12}>
                    <Row>
                        <Col xs={12} sm={12}>
                            <Card className="m-b-0 bg-c-mint-cream-new" style={{ 'backgroundColor': 'white' }}>
                                <Card.Header>
                                    <div className="card-header-left width-40" >
                                        <img src={mylanLogod} alt="" width="50px" height="50px" />
                                        <span><h4>Mylan Laboratories Limited, Indore</h4></span>
                                        
                                    </div>

                                    <div className="card-header-right p-3 width-60" style={{ 'cursor': 'pointer', 'display': 'flex', 'justifyContent': 'flex-end' }}>
                                        <h3 style={{ 'padding': '0px 25px 0px 0px' }}>EQUIPMENT / ROOM STATUS LABEL</h3>
                                        <span style={{ 'padding': '10px 5px' }}>
                                            {!isFullScreen ?
                                                <i className="fas fa-expand f-18" onClick={enterFullScreen}></i>
                                                :
                                                <i className="fas fa-compress f-18" onClick={exitFullScreen}></i>
                                            }
                                        </span>

                                    </div>

                                </Card.Header>

                                <Card.Body className="p-0">
                                    {
                                        props.rooms.error && props.rooms.error.length > 0
                                            ?
                                            <Alert variant="danger" >
                                                Something went wrong! Please try again.
                                            </Alert>
                                            : null
                                    }
                                    <Table bordered hover className="tblDashboard f-20 font-bold" size="sm" >
                                        <tbody>
                                            <tr>
                                                <td className="width-40">Equipment / Room Description</td>
                                                <td className="width-60 font-color" style={{ 'fontSize': '20px', 'fontWeight': 'bold' }}>
                                                    <span>{room.RoomDesc}  </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td className="width-40 " >Equipment / Room No.</td>
                                                <td className="font-color " style={{ 'fontSize': '20px', 'fontWeight': 'bold' }}>
                                                    <span>{room.RoomCode}  </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >Product Name</td>
                                                <td className="font-color" style={{ 'fontSize': '20px', 'fontWeight': 'bold', 'wordWrap': 'break-word', 'whiteSpace': 'normal' }}>
                                                    <span>{room.ProductDesc}  </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >Product Code</td>
                                                <td className="font-color" style={{ 'fontSize': '20px', 'fontWeight': 'bold' }}>
                                                    <span>{room.ProductCode}  </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >Batch Number</td>
                                                <td className="font-color" style={{ 'fontSize': '20px', 'fontWeight': 'bold' }}>
                                                    <span>{room.BatchNumber}  </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >Batch Size</td>
                                                <td className="font-color" style={{ 'fontSize': '20px', 'fontWeight': 'bold' }}>
                                                    {
                                                        room.BatchSize > 0
                                                            ?
                                                            <span>{room.BatchSize}&nbsp;{room.UOM} </span>
                                                            : null
                                                    }

                                                </td>
                                            </tr>
                                        </tbody>
                                    </Table>
                                    <Row className="text-center status-bgcolor-new p-0 m-0">
                                        <Col xs={12} sm={12} >
                                            <span className="font-color" style={{ 'fontSize': '28px', 'fontWeight': 'bold' }}>STATUS</span>
                                        </Col>
                                    </Row>
                                    <Row className="p-0 m-0">
                                        <Table bordered hover size="sm">
                                            <thead>
                                                <tr>
                                                    {
                                                        room.RoomLogs && room.RoomLogs.length > 0 &&
                                                        room.RoomLogs.map((log: RoomLog) => {
                                                            return <th style={{ 'fontSize': '22px', 'fontWeight': 'bold', 'background': 'white' }}>{log.RoomStatus}</th>
                                                        })
                                                    }
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr >
                                                    {
                                                        room.RoomLogs && room.RoomLogs.length > 0 &&
                                                        room.RoomLogs.map((log: RoomLog) => {
                                                            return <th style={{ 'fontWeight': 'bold', 'background': 'white' }} >
                                                                Sign / Date
                                                            </th>
                                                        })
                                                    }
                                                </tr>
                                                <tr className="f-18 font-bold">
                                                    {
                                                        room.RoomLogs && room.RoomLogs.length > 0 &&
                                                        room.RoomLogs.map((log: RoomLog) => {
                                                            return <th style={{ 'fontWeight': 'bold', 'background': 'white' }} >
                                                               {
                                                                    log.UserName ?
                                                                        <span>
                                                                            {
                                                                                log.UserName + ' / '
                                                                            }
                                                                        </span> : null
                                                                }
                                                                {
                                                                    log.TimeStamp ?
                                                                        <span>
                                                                            {
                                                                                new Date(log.TimeStamp ?? '').getDate() + '-' +
                                                                                (new Date(log.TimeStamp ?? '').getMonth() + 1) + '-' +
                                                                                new Date(log.TimeStamp ?? '').getFullYear()
                                                                            }
                                                                        </span> : null
                                                                }
                                                            </th>
                                                        })
                                                    }
                                                </tr>
                                             
                                            </tbody>
                                        </Table>
                                    </Row>
                                </Card.Body>
                                <Card.Footer> 
                                    <Row className='p-10 font-bold' >
                                        <Col xs={4} sm={4} className="text-left" >Reference:{room.ReferenceNumber}</Col>
                                        <Col xs={4} sm={4} className="text-center">Form:{room.FormNumber}</Col>
                                        <Col xs={4} sm={4} className="text-right" >Version:{room.VersionNumber}</Col>
                                    </Row>
                                </Card.Footer>
                            </Card>


                            {
                                canChangeBatchStatus
                                    ?
                                    <Row>
                                        <Col>
                                            <Card >
                                                <Card.Body className="pb-0">
                                                    <Row className="text-center m-25">
                                                        {
                                                            room.RoomLogs && room.RoomLogs.length > 0 &&
                                                            room.RoomLogs.map((log: RoomLog) => {
                                                                return <Col key={log.RoomStatusId} xs={12} sm={3}>
                                                                    {
                                                                        ((log.RoomStatus == 'No Activity' && canChangStatusNoActivity) ||
                                                                         (log.RoomStatus == 'Production' && canChangStatusProduction) ||
                                                                            (log.RoomStatus == 'Cleaning' && canChangStatusCleaning) ||
                                                                            (log.RoomStatus == 'Maintenance' && canChangStatusMaintainance)) ?
                                                                            <Card onClick={() => changeStatus(log)} style={{ 'cursor': 'pointer' }}>
                                                                                <Card.Body style={{ 'minHeight': '90px' }}>
                                                                                    <Row className="align-items-center" style={{ 'justifyContent': 'center' }}>
                                                                                        <Col sm={8}>


                                                                                        </Col>
                                                                                    </Row>
                                                                                </Card.Body>
                                                                                <Card.Footer
                                                                                    className={`
                                                            ${room.RoomCurrentStatus == log.RoomStatus ? "bg-c-green" : "bg-c-yellow"

                                                                                        }`}

                                                                                >
                                                                                    <Row className="row align-items-center">
                                                                                        <Col>
                                                                                            <h6 className="text-white m-b-0">{log.RoomStatus}</h6>
                                                                                        </Col>
                                                                                    </Row>
                                                                                </Card.Footer>
                                                                            </Card>
                                                                            : null

                                                                    }

                                                                </Col>
                                                            })}
                                                    </Row>
                                                </Card.Body>

                                            </Card>
                                        </Col>
                                    </Row>

                                    :
                                    null
                            }
                        </Col>
                    </Row>
                </Col>
            </Row>
        </FullScreen>

    </>);
};

const mapStateToProps = (state: RootState) => ({
    rooms: state.roomState as RoomState,
    permissions: state.authentication.permissions as IPermission[],
    loggedInUser: state.authentication.loggedInUser as any,
});
//this map actions to our props in this functional component
const mapActionsToProps = {
    changeRoomStatus,
    fetchAllRooms
}
export default connect(mapStateToProps, mapActionsToProps)(RoomDashboard);