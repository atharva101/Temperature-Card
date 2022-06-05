import React, { useEffect } from 'react';
import { Row, Col, Alert, Spinner, Button, Form, Modal, } from 'react-bootstrap';
import { RootState } from '../../../store/action-types';
import { useState } from 'react';
import { fetchAllRooms, selectRoom, RoomState, assignBatch, editBatchSize } from '../../../store/rooms/room.action';
import { useHistory } from 'react-router';
import { connect, useDispatch } from 'react-redux';
import { IRoomMaster } from '../../../models/master';
import { fetchRoomMasterData } from '../../../store/master/master.action';
import MaterialTable from "material-table";
import { BatchState, fetchAllBatches, saveBatch } from '../../../store/batch/batch.action';
import { IBatch } from '../../../models/batch';
import { IPermission } from '../../../models/role';
import { IRoom } from '../../../models/room';
import { IProduct } from '../../../models/product';
import { fetchAllProducts } from '../../../store/product/product.action';
import { IUOM } from '../../../models/uom';
import { fetchAllUOMs } from '../../../store/uom/uom.action';

interface ITableViewProps {
    rooms: RoomState;
    roomMaster: IRoomMaster[],
    batches: BatchState;
    permissions: IPermission[];
    products: IProduct[];
    uoms: IUOM[];
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

const TableView = (props: ITableViewProps) => {
    const [rooms, setRooms] = useState(props.rooms.rooms);
    const [roomMaster, setRoomMasters] = useState(props.roomMaster);
    const [roomId, setRoomId] = useState(0);
    const [batches, setBatches] = useState({} as IBatch[]);
    const [batch, setBatch] = useState({} as IBatch);
    const [validated, setValidated] = useState(false);
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

    const [configOpen, setConfigOpen] = useState(false);
    let configClass = ['menu-styler'];
    if (configOpen) {
        configClass = [...configClass, 'open'];
    }

    const history = useHistory();
    const dispatch = useDispatch();

    const [canAssignBatchToRoom, setCanAssignBatchToRoom] = useState(false);
    const [canCreateAndAssignBatch, setCanCreateAndAssignBatch] = useState(false);

    useEffect(() => {
        if (props.permissions && props.permissions.length > 0) {
            setCanAssignBatchToRoom(props.permissions.filter(x => x.PermissionName === 'Assign Batch to Room').length > 0 ? true : false);
            setCanCreateAndAssignBatch(props.permissions.filter(x => x.PermissionName === 'Create and Assign Batch').length > 0 ? true : false);
        }
    }, [props.permissions]);

    useEffect(() => {
        setRoomMasters(props.roomMaster);
    }, [props.roomMaster]);

    useEffect(() => {
        setRooms(props.rooms.rooms);
        setBatches(props.batches.batches);
    }, [props.rooms.rooms]);

    useEffect(() => {
        dispatch(fetchAllRooms());
        dispatch(fetchRoomMasterData());
        dispatch(fetchAllBatches(false)); // Show all batches
        dispatch(fetchAllProducts(true));
        dispatch(fetchAllUOMs(false));
    }, []);




    const redirectToRoomDashboard = (event: any, row: any) => {
        dispatch(selectRoom(row.RoomId));
        setRoomId(row.RoomId);
        history.push('/room-dashboard');
    }

    const handleOpen = (event: any, row: any) => {
        dispatch(selectRoom(row.RoomId));
        setRoomId(row.RoomId);
        dispatch(fetchAllBatches(false, row.RoomId));
        //setBatches(props.batches.batches);
        setOpen(true);
    };

    // deepak
    const [openBatchSize, setOpenBatch] = React.useState(false);
    const [selectedRoom, setSelectedRoom] = React.useState({} as IRoom);
    const handleCloseBatchSize = () => { setOpenBatch(false); };
    const handleOpenBatchSize = (event: any, row: any) => {
        setOpenBatch(true);
        setSelectedRoom(row);
    };


    const [open, setOpen] = React.useState(false);
    const handleClickOpen = () => {
        setOpen(true);
    };
    const handleClose = () => {
        setOpen(false);
    };

    useEffect(() => {
        if (props.batches.status === 'saved') {
            setOpen(false);
            dispatch(fetchAllRooms());
        }
    }, [props.batches.status]);


    const assignBatchToRoom = (selectedbatch: IBatch) => {
        dispatch(assignBatch(selectedbatch.Id, roomId))

    };
    useEffect(() => {
        if (props.rooms.status === 'saved') {
            setOpen(false);
            setOpenBatch(false);
            dispatch(fetchAllRooms());
        }

    }, [props.rooms.status]);

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

    const handleEditBatchSize = () => {
        if (selectedRoom.BatchSize > 0 && selectedRoom.UOM.length > 0) {
            setValidated(true);
            dispatch(editBatchSize(selectedRoom));
        }
        else {
            setValidated(false);
        }
    }
    const handleBatchSizeChanges = (e: React.ChangeEvent<HTMLInputElement>) => {
        e.preventDefault();
        const { name, value } = e.target;
        setSelectedRoom({
            ...selectedRoom,
            [name]: value,
        });
    }
    const handleSelectUOM = (e: React.ChangeEvent<HTMLSelectElement>) => {
        e.preventDefault();
        const { name, value } = e.target;
        setSelectedRoom({
            ...selectedRoom,
            [name]: value,
        });
    }
    const tableHeight = (window.innerHeight - 50 - 62 - 64 - 53 - 45 - 56) / window.innerHeight * 100;
    return (<>
        <Row>
            <Col>
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
                        <MaterialTable
                            title=""
                            columns={[
                                { title: 'Room #', field: 'RoomCode',
                            
                                 cellStyle: {
                                    minWidth: 100,
                                    maxWidth: 100
                                  }
                            
                            },
                                { title: 'Description', field: 'RoomDesc' ,
                            
                                cellStyle: {
                                   minWidth: 100,
                                   maxWidth: 100
                                 }},
                                {
                                    title: 'Product', field: 'ProductCode',
                            
                                    // cellStyle: {
                                    //    minWidth: 140,
                                    //    maxWidth: 140
                                    //  },
                                     width:'100%',
                                    render: rowData => rowData.ProductCode + (rowData.ProductDesc ? ' - ' : '') + rowData.ProductDesc
                                },
                                { title: 'Batch', field: 'BatchNumber' ,
                            
                                cellStyle: {
                                   minWidth: 90,
                                   maxWidth: 90
                                 }},
                                {
                                    title: 'Size', field: 'BatchSize',
                            
                                    cellStyle: {
                                       minWidth: 100,
                                       maxWidth: 100
                                     },
                                    render: rowData => rowData.BatchSize > 0 ? rowData.BatchSize.toString() + ' ' + rowData.UOM.toString() : ''
                                },
                                { title: 'Status', field: 'RoomCurrentStatus' ,
                            
                                cellStyle: {
                                   minWidth: 140,
                                   maxWidth: 140
                                 } }
                            ]}
                            data={rooms ? rooms : [] as IRoom[]}
                            actions={[
                                (rowData) => {
                                    
                                    return { icon: 'visibility', disable: true, tooltip:'Change Status', onClick: (event, row) => redirectToRoomDashboard(event, row) }
                                },
                                (rowData) => {
                                    return canAssignBatchToRoom && rowData.RoomCurrentStatus != 'Production'
                                        ? { icon: 'assignment_turned_in', disable: false,  tooltip:'Assign Batch', onClick: (event, rowData) => handleOpen(event, rowData) }
                                        : { icon: '', disable: true, onClick: (rowData) => { } }
                                },
                                (rowData) => {
                                    return canAssignBatchToRoom && rowData.BatchId > 0
                                        ? { icon: 'edit', disable: false, tooltip:'Edit Batch Size', onClick: (event, row) => handleOpenBatchSize(event, row) }
                                        : { icon: '', disable: true, onClick: (rowData) => { } }
                                }
                            ]}
                            options={{
                                search: true,
                                paging: false,
                                maxBodyHeight: `${tableHeight}vh`,
                                actionsColumnIndex: -1,
                                exportButton: true,
                                grouping: true
                            }}
                        />
                }

                <Modal size="lg" show={open} onClose={handleClose} centered>
                    <Modal.Header closeButton>
                        <Modal.Title id="contained-modal-title-vcenter">
                            Batch Assign
                        </Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                        <MaterialTable title=""
                            columns={[
                                {
                                    title: 'Batch #', field: 'BatchNumber',
                                    cellStyle: {
                                        minWidth: 90,
                                        maxWidth: 90
                                      },
                                },

                                {
                                    title: 'Batch Size', field: 'BatchSize',
                                    cellStyle: {
                                        minWidth: 100,
                                        maxWidth: 100
                                      },
                                    render: rowData => rowData.BatchSize && rowData.BatchSize > 0 ? rowData.BatchSize.toString() + ' ' + rowData.UOM.toString() : ''
                                },
                                {
                                    title: 'Product',
                                    field: 'ProductId',
                                    cellStyle: {
                                        minWidth: 400,
                                        maxWidth: 400
                                      },
                                    lookup: props.products.reduce(function (acc: any, cur: IProduct, i: number) {
                                        acc[cur.Id] = cur.Code + ' - ' + cur.Description;
                                        return acc;
                                    }, {}),
                                },
                                {
                                    title: 'Assign',
                                    field: 'Id',
                                    cellStyle: {
                                        minWidth: 50,
                                        maxWidth: 50
                                      },
                                    render: rowData => <Button size="sm" onClick={() => assignBatchToRoom(rowData)} color="danger">Assign</Button>
                                },
                            ]}
                            data={batches}

                            options={{
                                search: true,
                                paging: false,
                                maxBodyHeight: 400,

                                exportButton: true,
                                grouping: true,
                            }}
                        />
                    </Modal.Body>
                    <Modal.Footer>
                        <Button onClick={handleClose} color="danger">
                            Cancel
                        </Button>
                    </Modal.Footer>
                </Modal>
                <Modal size="lg" show={openBatchSize} onClose={handleCloseBatchSize} centered>
                    <Modal.Header closeButton>
                        <Modal.Title id="contained-modal-title-vcenter">
                            Edit Batch Size
                        </Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                        <Row>
                            <Col>
                                {
                                    props.rooms.error && props.rooms.error.length > 0
                                        ?
                                        <Alert variant="danger">
                                            {props.rooms.error}
                                        </Alert>
                                        : null
                                }
                                <Form id="edit-batch-size-form" noValidate validated={validated}>
                                    <Form.Row>
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Batch Size</Form.Label>
                                            <Form.Control
                                                required
                                                type="text"
                                                placeholder="Batch Size"
                                                name="BatchSize"
                                                defaultValue={selectedRoom.BatchSize}
                                                onChange={handleBatchSizeChanges}
                                            />
                                            <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                        </Form.Group>

                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Unit of Measure</Form.Label>
                                            <select value={selectedRoom.UOM ?? -1} className="form-control" name="UOM"
                                                onChange={handleSelectUOM}>
                                                <option value="">--Select--</option>
                                                {
                                                    props.uoms.map(u => {
                                                        return <option key={u.Id} value={u.Description}>{u.Description}</option>
                                                    })
                                                }
                                            </select>
                                            <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                        </Form.Group>
                                    </Form.Row>
                                </Form>

                            </Col>
                        </Row>
                    </Modal.Body>
                    <Modal.Footer>
                        <Button color="primary" onClick={handleEditBatchSize}>Save</Button>
                        <Button onClick={handleCloseBatchSize} color="danger">
                            Cancel
                        </Button>
                    </Modal.Footer>
                </Modal>
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
                                                roomMaster.filter(p => p.BlockId === x)[0].BlockDescription
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
                                                roomMaster.filter(p => p.AreaId === x)[0].AreaDescription
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
    roomMaster: state.masterState.master as IRoomMaster[],
    batches: state.batchState as BatchState,
    permissions: state.authentication.permissions as IPermission[],
    products: state.productState.products as IProduct[],
    uoms: state.uomState.uoms as IUOM[]
});

export default connect(mapStateToProps)(TableView)