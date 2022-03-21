import React, { useEffect } from 'react';
import { Row, Col, Card, Alert, Spinner, Button, } from 'react-bootstrap';
import { RootState } from '../../../store/action-types';
import { useState } from 'react';
import { fetchAllRooms, selectRoom, RoomState } from '../../../store/rooms/room.action';
import { useHistory } from 'react-router';
import { IRoom } from '../../../models/room';
import { connect, useDispatch } from 'react-redux';
import { IRoomMaster } from '../../../models/master';
import { fetchRoomMasterData } from '../../../store/master/master.action';
//import { Button } from '@material-ui/core';

interface ITileViewProps {
    rooms: RoomState;
    roomMaster: IRoomMaster[],
}

export interface IFilter {
    plantId: number;
    blockId: number;
    areaId: number;
    room: string;
    batch: string;
    product: string;
    statusId: number;
}

const TileView = (props: ITileViewProps) => {
    const [rooms, setRooms] = useState(props.rooms.rooms);
    const [roomMaster, setRoomMasters] = useState(props.roomMaster);


    const [filter, setFilters] = useState(
        {
            plantId: 0,
            blockId: 0,
            areaId: 0,
            room: '',
            batch: '',
            product: '',
            statusId: 0
        } as IFilter
    );

    const history = useHistory();
    const dispatch = useDispatch();

    const [configOpen, setConfigOpen] = useState(false);
    let configClass = ['menu-styler'];
    if (configOpen) {
        configClass = [...configClass, 'open'];
    }

    useEffect(() => {
        setRoomMasters(props.roomMaster);
    }, [props.roomMaster]);

    useEffect(() => {
        setRooms(props.rooms.rooms);
    }, [props.rooms.rooms]);

    useEffect(() => {
        dispatch(fetchAllRooms());
        dispatch(fetchRoomMasterData());
    }, []);


    const redirectToRoomDashboard = (roomId: number) => {
        dispatch(selectRoom(roomId));
        history.push('/room-dashboard');
    }

    const handleInputChanges = (e: React.ChangeEvent<HTMLInputElement>) => {
        e.preventDefault();
        const { name, value } = e.target;
        setFilters({
            ...filter,
            [name]: value,
        });

    }
    const handleSelectChanges = (e: any) => {
        e.preventDefault();
        const { name, value } = e.target;
        setFilters({
            ...filter,
            [name]: value,
        });
    }

    const handleApplyFilter = () => {
        console.log(filter);
        const roomIds = roomMaster.filter(x =>
            (filter.plantId == 0 || x.PlantId == filter.plantId)
            && (filter.areaId == 0 || x.AreaId == filter.areaId)
            && (filter.blockId == 0 || x.BlockId == filter.blockId)
        ).map(x => x.RoomId);
        setRooms(
            props.rooms.rooms.filter(x =>
                (
                    roomIds.length == 0
                    ||
                    roomIds.indexOf(x.RoomId) >= 0
                )
                && (filter.room.length === 0 ||
                    (x.RoomCode.toLowerCase().indexOf(filter.room.toLowerCase()) >= 0
                        || x.RoomDesc.toLowerCase().indexOf(filter.room.toLowerCase()) >= 0
                    )
                )
                && (filter.batch.length === 0 ||
                    (x.BatchNumber.toLowerCase().indexOf(filter.batch.toLowerCase()) >= 0)
                )
                && (filter.product.length === 0 ||
                    (x.ProductCode.toLowerCase().indexOf(filter.product.toLowerCase()) >= 0
                        || x.ProductDesc.toLowerCase().indexOf(filter.product.toLowerCase()) >= 0
                    )
                )
                && (filter.statusId == 0 || x.RoomStatusId == filter.statusId)
            )
        );
    }
    const handleClearFilter = () => {
        setFilters({
            plantId: 0,
            blockId: 0,
            areaId: 0,
            room: '',
            batch: '',
            product: '',
            statusId: 0
        } as IFilter);
        setRooms(props.rooms.rooms);
    }


    return (<>
        <Row>
            <Col xl={12} md={12}>
                {
                    props.rooms.error && props.rooms.error.length > 0
                        ?
                        <Alert variant="danger">
                            Something went wrong! Please relaod the page.
                        </Alert>
                        : null
                }
                {
                    props.rooms.status === 'inprogress'
                        ?
                        <Spinner animation="border" variant="primary" />
                        :
                        <Row>
                            {
                                rooms.map((room: IRoom) => {
                                    return <Col xs={12} sm={4} key={room.RoomId}>
                                        <Card onClick={() => room.BatchNumber && redirectToRoomDashboard(room.RoomId)} style={{ 'cursor': 'pointer' }}>
                                            <Card.Body style={{ 'minHeight': '160px' }}>

                                                <Row className="align-items-center">
                                                    <Col sm={9}>
                                                        <h4 className="text-c-green">Room # {room.RoomCode}</h4>
                                                        <h6 className="text-c-green">{room.RoomDesc}</h6>
                                                        <h6 className="text-muted m-b-5">{room.ProductCode ? room.ProductCode + ' - ' + room.ProductDesc : ''}</h6>
                                                        <h6 className="text-muted m-b-5">{room.BatchNumber ? 'Batch - ' + room.BatchNumber : ' '}</h6>
                                                        <h6 className="text-muted m-b-0"> {room.BatchSize > 0 ? 'Size - ' + room.BatchSize : ' '}</h6>
                                                    </Col>
                                                    <Col sm={3} className="text-right">
                                                        {/* <i className="feather icon-file-text f-28" /> */}
                                                        <i className="fas fa-user-cog f-28"></i>
                                                    </Col>
                                                </Row>
                                            </Card.Body>
                                            <Card.Footer
                                                className={`${room.RoomCurrentStatus ? "bg-c-blue" : "bg-c-gray"}`}>
                                                <Row className="row align-items-center">
                                                    <Col>
                                                        <h4 className="text-center text-white m-b-0">{room.RoomCurrentStatus ? room.RoomCurrentStatus : 'No Batch'}</h4>
                                                    </Col>
                                                </Row>
                                            </Card.Footer>
                                        </Card>
                                    </Col>

                                })
                            }
                        </Row>

                }

            </Col>
        </Row>

        <div id="styleSelector" className={configClass.join(' ')}>
            <div className="style-toggler">
                <a href="#/" onClick={() => setConfigOpen(!configOpen)}>
                    *
                </a>
            </div>
            <div className="style-block">
                <h4 className="mb-2 text-dark">
                    Filters
                </h4>
                <hr />
                <Row className="align-items-center">
                    <Col sm={6}>
                        Plant :
                        <select className="form-control" name="plantId" value={filter.plantId}
                            onChange={handleSelectChanges}>
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
                    </Col>
                    <Col sm={6}>
                        Block :
                        <select className="form-control" name="blockId" value={filter.blockId}
                            onChange={handleSelectChanges}>
                            <option>Select</option>
                            {
                                roomMaster.filter(x => x.PlantId == (filter.plantId > 0 ? filter.plantId : x.PlantId))
                                    .map((x: IRoomMaster) => x.BlockId)
                                    .filter((x, i: number, a) => a.indexOf(x) === i) //get Distinct
                                    .map((x, i) => {
                                        return <option key={i} value={x}>
                                            {
                                                roomMaster.filter(p => p.BlockId === x)[0].BlockCode
                                            }
                                        </option>
                                    })
                            }
                        </select>
                    </Col>
                </Row>
                <Row className="pt-3">
                    <Col sm={6}>
                        Area :
                        <select className="form-control" name="areaId" value={filter.areaId}
                            onChange={handleSelectChanges}>
                            <option>Select</option>
                            {
                                roomMaster.filter(x => x.BlockId == (filter.blockId > 0 ? filter.blockId : x.BlockId))
                                    .map((x: IRoomMaster) => x.AreaId)
                                    .filter((x, i: number, a) => a.indexOf(x) === i) //get Distinct
                                    .map((x, i) => {
                                        return <option key={i} value={x}>
                                            {
                                                roomMaster.filter(p => p.AreaId === x)[0].AreaCode
                                            }
                                        </option>
                                    })
                            }
                        </select>
                    </Col>
                    <Col sm={6}>
                        Room # :
                        <input type="text" className="form-control" name="room" value={filter.room}
                            onChange={handleInputChanges}></input>
                    </Col>
                </Row>
                <Row className="pt-3">
                    <Col sm={6}>
                        Batch :
                        <input type="text" className="form-control" name="batch" value={filter.batch}
                            onChange={handleInputChanges}></input>
                    </Col>
                    <Col sm={6}>
                        Product :
                        <input type="text" className="form-control" name="product" value={filter.product}
                            onChange={handleInputChanges}></input>
                    </Col>
                </Row>
                <Row className="pt-3">
                    <Col sm={6}>
                        Status # :
                        <select className="form-control" name="statusId" value={filter.statusId}
                            onChange={handleSelectChanges}>
                            <option>Select</option>
                        </select>
                    </Col>
                </Row>

                <Row className="pt-3">
                    <Col sm={12}>
                        <Button size="sm" variant="primary" className="btn-sm btn-round has-ripple m-3" onClick={handleApplyFilter}>
                            <i className="feather icon-filter" /> Filter
                        </Button>
                        <Button size="sm" variant="primary" className="btn-sm btn-round has-ripple m-3" onClick={handleClearFilter}>
                            <i className="feather icon-x" /> Clear Filter
                        </Button>
                    </Col>
                </Row>

            </div>
        </div>

    </>);
};

const mapStateToProps = (state: RootState) => ({
    rooms: state.roomState as RoomState,
    roomMaster: state.masterState.master as IRoomMaster[]
});
//this map actions to our props in this functional component

export default connect(mapStateToProps)(TileView)