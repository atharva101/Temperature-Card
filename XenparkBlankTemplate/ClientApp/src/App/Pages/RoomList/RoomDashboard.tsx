import React, { useEffect, useState } from 'react';
import { Row, Col, Card, Alert, Table, Dropdown } from 'react-bootstrap';
import { FullScreen, useFullScreenHandle } from "react-full-screen";
import { IRoom, RoomLog } from '../../../models/room';
import { RootState } from '../../../store/action-types';
import { RoomState, changeRoomStatus, fetchAllRooms } from '../../../store/rooms/room.action';
import { connect } from 'react-redux';
import { HubConnection, HubConnectionBuilder } from "@microsoft/signalr";
import { IPermission } from '../../../models/role';
import mylanLogo from '../../../assets/images/mylan-logo.svg';

interface IRoomDashboardProps {
    rooms: RoomState;
    changeRoomStatus: any;
    fetchAllRooms: any;
    permissions: IPermission[];
}
const RoomDashboard = (props: IRoomDashboardProps) => {
    const fullScreenHandle = useFullScreenHandle();
    const [isFullScreen, setFullScreen] = useState(false);
    const [status, setStatus] = useState('');

    const [currentWorkflowState, setCurrentWorkflowState] = useState({} as RoomLog);
    const [connection, setConnection] = useState<null | HubConnection>(null);

    const [canAssignBatchToRoom, setCanAssignBatchToRoom] = useState(false);
    const [canChangeBatchStatus, setCanChangeBatchStatus] = useState(false);
    const [theme, setTheme] = useState(1);
    useEffect(() => {
        if (props.permissions && props.permissions.length > 0) {
            setCanAssignBatchToRoom(props.permissions.filter(x => x.PermissionName === 'Assign Batch to Room').length > 0 ? true : false);
            setCanChangeBatchStatus(props.permissions.filter(x => x.PermissionName === 'Change Batch Status').length > 0 ? true : false);
        }
    }, [props.permissions]);


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
        if (log.RoomStatusOrder === currentWorkflowState.RoomStatusOrder + 1) {
            await Promise.all([
                props.changeRoomStatus(room.RoomId, room.BatchId, log.RoomStatusId)
            ]);

            if (connection) await connection.send("SendMessage", "RoomStatusChanged");

        }
        else if (currentWorkflowState.IsFinal === true && log.RoomStatusOrder === 1) {
            const status = room.RoomLogs.filter(x => x.RoomStatusOrder === 1);
            await Promise.all([
                props.changeRoomStatus(room.RoomId, room.BatchId, status[0].RoomStatusId)
            ]);

            if (connection) await connection.send("SendMessage", "RoomStatusChanged");
        }
        else {
            return false;
        }
    }
    return (<>
        <FullScreen handle={fullScreenHandle}>
            <Row>
                <Col xl={12} md={12}>
                    {
                        theme === 1 ?
                            <Row>
                                <Col xs={12} sm={12}>
                                    <Card className="m-b-0 bg-c-mint-cream-new">
                                        <Card.Header>
                                            <div className="card-header-left width-40" >
                                                <img src={mylanLogo} alt="" width="120px" />

                                            </div>

                                            <div className="card-header-right p-3 width-60" style={{ 'cursor': 'pointer', 'display': 'flex', 'justifyContent': 'flex-end' }}>
                                                <h5 style={{ 'padding': '0px 25px 0px 0px' }}>EQUIPMENT / ROOM STATUS LABEL</h5>
                                                <span style={{ 'padding': '0px 5px' }}>
                                                    {!isFullScreen ?
                                                        <i className="fas fa-expand f-18" onClick={enterFullScreen}></i>
                                                        :
                                                        <i className="fas fa-compress f-18" onClick={exitFullScreen}></i>
                                                    }
                                                </span>
                                                <span style={{ 'padding': '0px 5px' }}>
                                                    <Dropdown>
                                                        <Dropdown.Toggle variant="success" id="dropdown-basic">
                                                            <i className="fas fa-align-justify f-18"></i>
                                                        </Dropdown.Toggle>
                                                        <Dropdown.Menu>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(1)}>Theme 1</Dropdown.Item>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(2)}>Theme 2</Dropdown.Item>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(3)}>Theme 3</Dropdown.Item>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(4)}>Theme 4</Dropdown.Item>
                                                        </Dropdown.Menu>
                                                    </Dropdown>
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
                                                        <td className="width-60 font-color" style={{ 'fontSize': '40px', 'fontWeight': 'bold' }}>
                                                            <span>{room.RoomDesc}  </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td className="width-40 " >Equipment / Room No.</td>
                                                        <td className="font-color " style={{ 'fontSize': '40px', 'fontWeight': 'bold' }}>
                                                            <span>{room.RoomCode}  </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >Product Name</td>
                                                        <td className="font-color" style={{ 'fontSize': '40px', 'fontWeight': 'bold' }}>
                                                            <span>{room.ProductDesc}  </span>
                                                            {/* <div className="bounce">
                                                        <p>{room.ProductDesc} </p>
                                                    </div> */}
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >Product Code</td>
                                                        <td className="font-color" style={{ 'fontSize': '40px', 'fontWeight': 'bold' }}>
                                                            <span>{room.ProductCode}  </span>
                                                            {/* <div className="bounce">
                                                        <p>{room.ProductCode} </p>
                                                    </div> */}
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >Batch Number</td>
                                                        <td className="font-color" style={{ 'fontSize': '40px', 'fontWeight': 'bold' }}>
                                                            <span>{room.BatchNumber}  </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >Batch Size</td>
                                                        <td className="font-color" style={{ 'fontSize': '40px', 'fontWeight': 'bold' }}>
                                                            {
                                                                room.BatchSize > 0

                                                                    ?
                                                                    <span>{room.BatchSize}  </span>
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
                                                                room.RoomLogs.filter(x => x.RoomStatusOrder > 1).map((log: RoomLog) => {
                                                                    return <th style={{ 'fontSize': '22px', 'fontWeight': 'bold', 'background': '#F5FFEA' }}>{log.RoomStatus}</th>
                                                                })
                                                            }
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr >
                                                            {
                                                                room.RoomLogs && room.RoomLogs.length > 0 &&
                                                                room.RoomLogs.filter(x => x.RoomStatusOrder > 1).map((log: RoomLog) => {
                                                                    return <th style={{ 'fontWeight': 'bold', 'background': '#F5FFEA' }} >
                                                                        SIGN / DATE
                                                                    </th>
                                                                })
                                                            }
                                                        </tr>
                                                        <tr className="f-18 font-bold">
                                                            {
                                                                room.RoomLogs && room.RoomLogs.length > 0 &&
                                                                room.RoomLogs.filter(x => x.RoomStatusOrder > 1).map((log: RoomLog) => {
                                                                    return <th style={{ 'fontWeight': 'bold', 'background': '#F5FFEA' }} >
                                                                        {
                                                                            log.TimeStamp ?
                                                                                <span>
                                                                                    {
                                                                                        new Date(log.TimeStamp ?? '').getDate() + '/' +
                                                                                        (new Date(log.TimeStamp ?? '').getMonth() + 1) + '/' +
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
                                    </Card>
                                </Col>
                            </Row>

                            : null
                    }
                    {
                        theme === 2
                            ?
                            <Row>
                                <Col xs={12} sm={12}>
                                    <Card className="m-b-0 bg-c-mint-cream">
                                        <Card.Header>
                                            <div className="card-header-left width-40" >
                                                <img src={mylanLogo} alt="" width="120px" />

                                            </div>

                                            <div className="card-header-right p-3 width-60" style={{ 'cursor': 'pointer', 'display': 'flex', 'justifyContent': 'flex-end' }}>
                                                <h5 style={{ 'padding': '0px 25px 0px 0px' }}>EQUIPMENT / ROOM STATUS LABEL</h5>
                                                <span style={{ 'padding': '0px 5px' }}>
                                                    {!isFullScreen ?
                                                        <i className="fas fa-expand f-18" onClick={enterFullScreen}></i>
                                                        :
                                                        <i className="fas fa-compress f-18" onClick={exitFullScreen}></i>
                                                    }
                                                </span>
                                                <span style={{ 'padding': '0px 5px' }}>
                                                    <Dropdown>
                                                        <Dropdown.Toggle variant="success" id="dropdown-basic">
                                                            <i className="fas fa-align-justify f-18"></i>
                                                        </Dropdown.Toggle>
                                                        <Dropdown.Menu>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(1)}>Theme 1</Dropdown.Item>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(2)}>Theme 2</Dropdown.Item>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(3)}>Theme 3</Dropdown.Item>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(4)}>Theme 4</Dropdown.Item>
                                                        </Dropdown.Menu>
                                                    </Dropdown>
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
                                                        <td className="width-60 font-color" style={{ 'fontSize': '40px', 'fontWeight': 'bold' }}>
                                                            <span>{room.RoomDesc}  </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td className="width-40 " >Equipment / Room No.</td>
                                                        <td className="font-color " style={{ 'fontSize': '40px', 'fontWeight': 'bold' }}>
                                                            <span>{room.RoomCode}  </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >Product Name</td>
                                                        <td className="font-color" style={{ 'fontSize': '40px', 'fontWeight': 'bold' }}>

                                                            <div className="bounce">
                                                                <p>{room.ProductDesc} </p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >Product Code</td>
                                                        <td className="font-color" style={{ 'fontSize': '40px', 'fontWeight': 'bold' }}>

                                                            <div className="bounce">
                                                                <p>{room.ProductCode} </p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >Batch Number</td>
                                                        <td className="font-color" style={{ 'fontSize': '40px', 'fontWeight': 'bold' }}>

                                                            <div className="bounce">
                                                                <p> {room.BatchNumber} </p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >Batch Size</td>
                                                        <td className="font-color" style={{ 'fontSize': '40px', 'fontWeight': 'bold' }}>
                                                            {
                                                                room.BatchSize > 0
                                                                    ? <div className="bounce">
                                                                        <p>{room.BatchSize} </p>
                                                                    </div>
                                                                    : null
                                                            }

                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </Table>
                                            <Row className="text-center status-bgcolor p-0 m-0">
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
                                                                room.RoomLogs.filter(x => x.RoomStatusOrder > 1).map((log: RoomLog) => {
                                                                    return <th style={{ 'fontSize': '22px', 'fontWeight': 'bold', 'background': '#D8E4BC' }}>{log.RoomStatus}</th>
                                                                })
                                                            }
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr >
                                                            {
                                                                room.RoomLogs && room.RoomLogs.length > 0 &&
                                                                room.RoomLogs.filter(x => x.RoomStatusOrder > 1).map((log: RoomLog) => {
                                                                    return <th >
                                                                        SIGN / DATE
                                                                    </th>
                                                                })
                                                            }
                                                        </tr>
                                                        <tr className="f-18 font-bold">
                                                            {
                                                                room.RoomLogs && room.RoomLogs.length > 0 &&
                                                                room.RoomLogs.filter(x => x.RoomStatusOrder > 1).map((log: RoomLog) => {
                                                                    return <th>
                                                                        {
                                                                            log.TimeStamp ?
                                                                                <span >
                                                                                    {
                                                                                        new Date(log.TimeStamp ?? '').getDate() + '/' +
                                                                                        (new Date(log.TimeStamp ?? '').getMonth() + 1) + '/' +
                                                                                        new Date(log.TimeStamp ?? '').getFullYear()
                                                                                    }
                                                                                </span> : null
                                                                        }
                                                                    </th>
                                                                })
                                                            }
                                                        </tr>
                                                        {/* <tr className="p-0">
                                                    {
                                                        room.RoomLogs && room.RoomLogs.length > 0 ?
                                                            <td  colSpan={room.RoomLogs.length}>MLLFD3-SOP-SD-GEN-0008 A03-00-01-15</td>
                                                            :
                                                            <td></td>
                                                    }
                                                </tr> */}
                                                    </tbody>
                                                </Table>
                                            </Row>


                                        </Card.Body>

                                    </Card>
                                </Col>
                            </Row>

                            : null

                    }
                    {
                        theme === 3
                            ?
                            <Row>
                                <Col xs={12} sm={12}>
                                    <Card className="m-b-0">
                                        <Card.Header>
                                            <div className="card-header-left width-40" >
                                                <img src={mylanLogo} alt="" width="120px" />

                                            </div>

                                            <div className="card-header-right p-3 width-60" style={{ 'cursor': 'pointer', 'display': 'flex', 'justifyContent': 'flex-end' }}>
                                                <h5 style={{ 'padding': '0px 25px 0px 0px' }}>EQUIPMENT / ROOM STATUS LABEL</h5>
                                                <span style={{ 'padding': '0px 5px' }}>
                                                    {!isFullScreen ?
                                                        <i className="fas fa-expand f-18" onClick={enterFullScreen}></i>
                                                        :
                                                        <i className="fas fa-compress f-18" onClick={exitFullScreen}></i>
                                                    }
                                                </span>
                                                <span style={{ 'padding': '0px 5px' }}>
                                                    <Dropdown>
                                                        <Dropdown.Toggle variant="success" id="dropdown-basic">
                                                            <i className="fas fa-align-justify f-18"></i>
                                                        </Dropdown.Toggle>
                                                        <Dropdown.Menu>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(1)}>Theme 1</Dropdown.Item>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(2)}>Theme 2</Dropdown.Item>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(3)}>Theme 3</Dropdown.Item>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(4)}>Theme 4</Dropdown.Item>
                                                        </Dropdown.Menu>
                                                    </Dropdown>
                                                </span>

                                            </div>

                                        </Card.Header>

                                        <Card.Body className="pb-0">
                                            {
                                                props.rooms.error && props.rooms.error.length > 0
                                                    ?
                                                    <Alert variant="danger">
                                                        Something went wrong! Please try again.
                                                    </Alert>
                                                    : null
                                            }

                                            <Row className="text-center m-25">
                                                <Col xs={12} sm={12}>
                                                    <h1>Room # {room.RoomCode}</h1>
                                                    <h4>{room.RoomDesc}</h4>
                                                </Col>
                                            </Row>
                                            {
                                                room.ProductCode ?
                                                    <Row className="text-center m-25">
                                                        <Col xs={12} sm={12}>
                                                            <h3>{room.ProductCode} - {room.ProductDesc} </h3>
                                                        </Col>
                                                    </Row>
                                                    : null
                                            }
                                            {
                                                room.BatchNumber ?
                                                    <Row className="text-center m-25">
                                                        <Col xs={12} sm={6}>
                                                            <h3> Batch : {room.BatchNumber}</h3>
                                                        </Col>
                                                        <Col xs={12} sm={6}>
                                                            <h3>Batch Size : {room.BatchSize}</h3>
                                                        </Col>
                                                    </Row>
                                                    : null
                                            }


                                        </Card.Body>
                                        <Card.Footer className="bg-primary ">
                                            <Row className="text-center text-white">
                                                <Col>
                                                    <h1 className="m-0 text-white">{room.RoomCurrentStatus}</h1>
                                                </Col>
                                            </Row>
                                        </Card.Footer>
                                    </Card>
                                </Col>
                            </Row>
                            : null
                    }

                    {
                        theme === 4
                            ?
                            <Row>
                                <Col xs={12} sm={12}>
                                    <Card className="m-b-0 bg-c-black">
                                        <Card.Header>
                                            <div className="card-header-left width-40" >
                                                <img src={mylanLogo} alt="" width="120px" />

                                            </div>

                                            <div className="card-header-right p-3 width-60" style={{ 'cursor': 'pointer', 'display': 'flex', 'justifyContent': 'flex-end' }}>
                                                <h5 style={{ 'padding': '0px 25px 0px 0px' }}>EQUIPMENT / ROOM STATUS LABEL</h5>
                                                <span style={{ 'padding': '0px 5px' }}>
                                                    {!isFullScreen ?
                                                        <i className="fas fa-expand f-18" onClick={enterFullScreen}></i>
                                                        :
                                                        <i className="fas fa-compress f-18" onClick={exitFullScreen}></i>
                                                    }
                                                </span>
                                                <span style={{ 'padding': '0px 5px' }}>
                                                    <Dropdown>
                                                        <Dropdown.Toggle variant="success" id="dropdown-basic">
                                                            <i className="fas fa-align-justify f-18"></i>
                                                        </Dropdown.Toggle>
                                                        <Dropdown.Menu>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(1)}>Theme 1</Dropdown.Item>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(2)}>Theme 2</Dropdown.Item>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(3)}>Theme 3</Dropdown.Item>
                                                            <Dropdown.Item href="#/" onClick={() => setTheme(4)}>Theme 4</Dropdown.Item>
                                                        </Dropdown.Menu>
                                                    </Dropdown>
                                                </span>

                                            </div>

                                        </Card.Header>

                                        <Card.Body className="pb-0">
                                            {
                                                props.rooms.error && props.rooms.error.length > 0
                                                    ?
                                                    <Alert variant="danger" className="font-color-white">
                                                        Something went wrong! Please try again.
                                                    </Alert>
                                                    : null
                                            }
                                            <Table bordered hover className="f-18 font-bold" >
                                                <tbody>
                                                    <tr>
                                                        <td className="width-40 font-color-white">Equipment / Room Description</td>
                                                        <td className="width-60 font-color-white" style={{ 'fontSize': '26px', 'fontWeight': 'bold' }}>
                                                            <span className="animatetext">{room.RoomDesc}  </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td className="font-color-white">Equipment / Room No.</td>
                                                        <td className="font-color-white " style={{ 'fontSize': '26px', 'fontWeight': 'bold' }}>

                                                            <span className="animatetext">{room.RoomCode}  </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td className="font-color-white">Product Name</td>
                                                        <td className="font-color-white" style={{ 'fontSize': '26px', 'fontWeight': 'bold' }}>

                                                            <div className="bounce">
                                                                <p>{room.ProductDesc} </p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td className="font-color-white">Product Code</td>
                                                        <td className="font-color-white" style={{ 'fontSize': '26px', 'fontWeight': 'bold' }}>

                                                            <div className="bounce">
                                                                <p>{room.ProductCode} </p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td className="font-color-white">Batch Number</td>
                                                        <td className="font-color-white" style={{ 'fontSize': '26px', 'fontWeight': 'bold' }}>

                                                            <div className="bounce">
                                                                <p> {room.BatchNumber} </p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td className="font-color-white">Batch Size</td>
                                                        <td className="font-color-white" style={{ 'fontSize': '26px', 'fontWeight': 'bold' }}>

                                                            <div className="bounce">
                                                                <p>{room.BatchSize} </p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </Table>
                                            <Row className="text-center m-25">
                                                <Col xs={12} sm={12}>
                                                    <h3 className="font-color-white">STATUS</h3>
                                                </Col>
                                            </Row>
                                            <Row className="m-25">
                                                <Table bordered hover >
                                                    <thead>
                                                        <tr className="f-18 font-bold">
                                                            {
                                                                room.RoomLogs && room.RoomLogs.length > 0 &&
                                                                room.RoomLogs.filter(x => x.RoomStatusOrder > 1).map((log: RoomLog) => {
                                                                    return <th className="font-color-white" style={{ 'fontSize': '18px', 'fontWeight': 'bold' }}>{log.RoomStatus}</th>
                                                                })
                                                            }
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr >
                                                            {
                                                                room.RoomLogs && room.RoomLogs.length > 0 &&
                                                                room.RoomLogs.filter(x => x.RoomStatusOrder > 1).map((log: RoomLog) => {
                                                                    return <th className="font-color-white">
                                                                        SIGN / DATE
                                                                    </th>
                                                                })
                                                            }
                                                        </tr>
                                                        <tr className="f-18 font-bold">
                                                            {
                                                                room.RoomLogs && room.RoomLogs.length > 0 &&
                                                                room.RoomLogs.filter(x => x.RoomStatusOrder > 1).map((log: RoomLog) => {
                                                                    return <th>
                                                                        {
                                                                            log.TimeStamp ?
                                                                                <span className="font-color-white">
                                                                                    {
                                                                                        new Date(log.TimeStamp ?? '').getDate() + '/' +
                                                                                        (new Date(log.TimeStamp ?? '').getMonth() + 1) + '/' +
                                                                                        new Date(log.TimeStamp ?? '').getFullYear()
                                                                                    }
                                                                                </span> : null
                                                                        }
                                                                    </th>
                                                                })
                                                            }
                                                        </tr>
                                                        {/* <tr className="p-0">
                                                    {
                                                        room.RoomLogs && room.RoomLogs.length > 0 ?
                                                            <td className="font-color-white" colSpan={room.RoomLogs.length}>MLLFD3-SOP-SD-GEN-0008 A03-00-01-15</td>
                                                            :
                                                            <td></td>
                                                    }
                                                </tr> */}
                                                    </tbody>
                                                </Table>
                                            </Row>


                                        </Card.Body>

                                    </Card>
                                </Col>
                            </Row>
                            :
                            null
                    }
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
                                                            <Card onClick={() => changeStatus(log)} style={{ 'cursor': 'pointer' }}>
                                                                <Card.Body style={{ 'minHeight': '90px' }}>
                                                                    <Row className="align-items-center">
                                                                        <Col sm={8}>
                                                                            {
                                                                                log.TimeStamp ?
                                                                                    <>
                                                                                        <h6 className="text-muted m-b-0">
                                                                                            {
                                                                                                new Date(log.TimeStamp ?? '').getDate() + '/' +
                                                                                                (new Date(log.TimeStamp ?? '').getMonth() + 1) + '/' +
                                                                                                new Date(log.TimeStamp ?? '').getFullYear()


                                                                                            }
                                                                                        </h6>
                                                                                        <h6 className="text-muted m-b-0">
                                                                                            {
                                                                                                (new Date(log.TimeStamp ?? '').getHours() + 1) + ':' +
                                                                                                (new Date(log.TimeStamp ?? '').getMinutes() + 1) + ':' +
                                                                                                (new Date(log.TimeStamp ?? '').getSeconds() + 1)
                                                                                            }
                                                                                        </h6>
                                                                                    </>
                                                                                    : null
                                                                            }


                                                                        </Col>
                                                                        <Col sm={4} className="text-right">
                                                                            {
                                                                                log.IsFinal
                                                                                    ?
                                                                                    <i className="feather icon-corner-down-left f-28" />
                                                                                    :
                                                                                    <i className="feather icon-arrow-right f-28" />
                                                                            }
                                                                        </Col>
                                                                    </Row>
                                                                </Card.Body>
                                                                <Card.Footer
                                                                    //className = "bg-c-green"

                                                                    className={`
                                                            ${log.IsCurrent ? "bg-c-blue"
                                                                            : currentWorkflowState.IsFinal === true && log.RoomStatusOrder === 1 ? "bg-c-yellow"
                                                                                : log.RoomStatusOrder === currentWorkflowState.RoomStatusOrder + 1 ? "bg-c-yellow"
                                                                                    : log.IsPrev ? "bg-c-green"
                                                                                        : "bg-c-gray"
                                                                        }`}
                                                                >
                                                                    <Row className="row align-items-center">
                                                                        <Col>
                                                                            <h6 className="text-white m-b-0">{log.RoomStatus}</h6>
                                                                        </Col>
                                                                    </Row>
                                                                </Card.Footer>
                                                            </Card>
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
        </FullScreen>

    </>);
};

const mapStateToProps = (state: RootState) => ({
    rooms: state.roomState as RoomState,
    permissions: state.authentication.permissions as IPermission[]
});
//this map actions to our props in this functional component
const mapActionsToProps = {
    changeRoomStatus,
    fetchAllRooms
}
export default connect(mapStateToProps, mapActionsToProps)(RoomDashboard);