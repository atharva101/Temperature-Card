import React, { useEffect } from 'react';
import { Row, Col, Alert, Spinner, Button, Form, } from 'react-bootstrap';
import { RootState } from '../../../store/action-types';
import { useState } from 'react';
import { fetchAllRooms, selectRoom, RoomState, assignBatch } from '../../../store/rooms/room.action';
import { useHistory } from 'react-router';
import { connect, useDispatch } from 'react-redux';
import { IRoomMaster } from '../../../models/master';
import { fetchRoomMasterData } from '../../../store/master/master.action';
import MaterialTable from "material-table";
import { Dialog, DialogActions, DialogContent, DialogTitle } from '@material-ui/core';
import MaintainBatch from '../Batch/MaintainBatch';
import { BatchState, fetchAllBatches, saveBatch } from '../../../store/batch/batch.action';
import { IBatch } from '../../../models/batch';
import { IPermission } from '../../../models/role';
import { IRoom } from '../../../models/room';
import { IProduct } from '../../../models/product';
import { fetchAllProducts } from '../../../store/product/product.action';

interface ITableViewProps {
    rooms: RoomState;
    roomMaster: IRoomMaster[],
    batches: BatchState;
    permissions: IPermission[];
    products: IProduct[];
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
    const [validated, setValidated] = useState(false);
    const [rooms, setRooms] = useState(props.rooms.rooms);
    const [roomMaster, setRoomMasters] = useState(props.roomMaster);
    const [roomId, setRoomId] = useState(0);
    const [batches, setBatches] = useState({} as IBatch[]);
    const [batch, setBatch] = useState({} as IBatch);
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

    //const [batches, setBatches] = useState([] as IBatch[]);
    const [batchId, setBatchId] = useState(0);


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
        setBatchId(0);
    }, [props.rooms.rooms]);

    useEffect(() => {
        dispatch(fetchAllRooms());
        dispatch(fetchRoomMasterData());
        dispatch(fetchAllBatches(true));
        dispatch(fetchAllProducts(true));
    }, []);




    const redirectToRoomDashboard = (event: any, row: any) => {
        dispatch(selectRoom(row.RoomId));
        setRoomId(row.RoomId);
        history.push('/room-dashboard');
    }

    const [openBatch, setOpenBatch] = React.useState(false);
    const handleCloseBatch = () => {
        setOpenBatch(false);
    };

    const handleOpen = (event: any, row: any) => {
        dispatch(selectRoom(row.RoomId));
        setRoomId(row.RoomId);
        dispatch(fetchAllBatches(true, row.RoomId));
        //setBatches(props.batches.batches);
        setOpen(true);
    };

    const handleClickOpenBatch = () => {
        setOpenBatch(true);
    };

    const handlBatchChange = (e: any) => {
        const { name, value } = e.target;
        setBatches({
            ...batches,
            [name]: value,
        });
        setBatchId(parseInt(e.target.value));
    }

    const [open, setOpen] = React.useState(false);
    const handleClickOpen = () => {
        setOpen(true);
    };
    const handleClose = () => {
        setOpen(false);
    };
    const handleSelectProduct = (e: any) => {
        e.preventDefault();
        const { name, value } = e.target;
        setBatch({
            ...batch,
            [name]: value,
        });
    }
    const handleCreateBatch = async (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();
        const form = event.currentTarget;
        if (form.checkValidity() === false) {
            event.stopPropagation();
        }
        setValidated(true);
        let tempBatch = batch;
        tempBatch = { ...batch, BatchLogger: [{ Id: 0, BatchId: 0, RoomId: roomId, TimeStamp: '' }] }
        dispatch(saveBatch(tempBatch))
    };

    useEffect(() => {
        if (props.batches.status === 'saved') {
            setOpen(false);
            dispatch(fetchAllRooms());
        }
    }, [props.batches.status]);


    const handleFormSubmit = () => {
        dispatch(assignBatch(batchId, roomId))

    };
    useEffect(() => {
        if (props.rooms.status === 'saved') {
            setOpen(false);
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
    const handleBatchChanges = (e: React.ChangeEvent<HTMLInputElement>) => {
        e.preventDefault();
        const { name, value } = e.target;
        setBatch({
            ...batch,
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
    const [radioValue, setRadioValue] = useState('assignbatch');
    const onRadioChangeValue = (event: any) => {
        setRadioValue(event.target.value);
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
                                { title: 'Room No.', field: 'RoomCode' },
                                { title: 'Description', field: 'RoomDesc' },
                                {
                                    title: 'Product', field: 'ProductCode',
                                    render: rowData => rowData.ProductCode + (rowData.ProductDesc ? ' - ' : '') + rowData.ProductDesc
                                },
                                { title: 'Batch', field: 'BatchNumber' },
                                {
                                    title: 'Size', field: 'BatchSize',
                                    render: rowData => rowData.BatchSize > 0 ? rowData.BatchSize.toString() : ''
                                },
                                { title: 'Status', field: 'RoomCurrentStatus' }
                            ]}
                            data={rooms ? rooms : [] as IRoom[]}
                            // actions={[
                            //     {
                            //         icon: 'visibility',
                            //         tooltip: 'View',
                            //         onClick: (event, row) => redirectToRoomDashboard(event, row),

                            //     },
                            //     {
                            //         icon: 'assignment_turned_in',
                            //         tooltip: 'Assign Batch',
                            //         onClick: (event, rowData) => handleOpen(event, rowData),

                            //     }
                            // ]}
                            actions={[
                                (rowData) => {
                                    return { icon: 'visibility', disable: true, onClick: (event, row) => redirectToRoomDashboard(event, row) }
                                },
                                (rowData) => {
                                    return canAssignBatchToRoom && (rowData.BatchId < 1 && (rowData.RoomStatusOrder == 1 || rowData.RoomStatusOrder == -1))
                                        ? { icon: 'assignment_turned_in', disable: false, onClick: (event, rowData) => handleOpen(event, rowData) }
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
            </Col>
        </Row>

        <div>
            <Dialog open={open} onClose={handleClose} aria-labelledby="form-dialog-title">
                <DialogTitle id="form-dialog-title">Batch Assign</DialogTitle>
                <DialogContent>
                    <Row>
                        <Col>
                            <div className="input-group">
                                <input type="radio" name="batch" value="assignbatch"
                                    checked={radioValue === 'assignbatch'}
                                    onChange={(e) => onRadioChangeValue(e)} />
                                <h6 style={{ paddingLeft: '10px' }}>Select Batch</h6>
                            </div>
                            <select value={batchId} className="form-control" name="batchId"
                                onChange={handlBatchChange}>
                                <option>Select</option>
                                {
                                    props.batches.batches && props.batches.batches.map((p, index) => {
                                        return <option key={index} value={p.Id}>{p.BatchNumber} </option>
                                    })
                                }
                            </select>
                        </Col>
                    </Row>
                    {
                        canCreateAndAssignBatch ?
                            <>
                                <Row><Col> <h6 style={{ padding: '10px', textAlign: 'center' }}>OR</h6></Col> </Row>
                                <Row>
                                    <Col>
                                        <div className="input-group">
                                            <input type="radio" name="batch" value="createbatch"
                                                checked={radioValue === 'createbatch'}
                                                onChange={(e) => onRadioChangeValue(e)} />
                                            <h6 style={{ paddingLeft: '10px' }}>Create and Assign Batch</h6>
                                        </div>
                                    </Col>
                                </Row>
                                <Row>
                                    <Col>
                                        {
                                            props.batches.error && props.batches.error.length > 0
                                                ?
                                                <Alert variant="danger">
                                                    {props.batches.error}
                                                </Alert>
                                                : null
                                        }
                                        <Form id="batch-form" noValidate validated={validated} onSubmit={handleCreateBatch}>
                                            <Form.Row>
                                                <Form.Group as={Col} md="6" >
                                                    <Form.Label>Batch #</Form.Label>
                                                    <Form.Control
                                                        required
                                                        type="text"
                                                        placeholder="Batch #"
                                                        name="BatchNumber"
                                                        defaultValue={batch.BatchNumber}
                                                        onChange={handleBatchChanges}
                                                        disabled={radioValue === 'assignbatch'}
                                                    />
                                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                                </Form.Group>
                                                <Form.Group as={Col} md="6">
                                                    <Form.Label>Batch Size</Form.Label>
                                                    <Form.Control
                                                        required
                                                        type="text"
                                                        placeholder="Batch Size"
                                                        name="BatchSize"
                                                        defaultValue={batch.BatchSize}
                                                        onChange={handleBatchChanges}
                                                        disabled={radioValue === 'assignbatch'}
                                                    />
                                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                                </Form.Group>

                                                <Form.Group as={Col} md="6">
                                                    <Form.Label>Product</Form.Label>
                                                    <select value={batch.ProductId ?? -1} className="form-control" name="ProductId"
                                                        onChange={handleSelectProduct} disabled={radioValue === 'assignbatch'}>
                                                        <option value="">--Select--</option>
                                                        {
                                                            props.products.map(product => {
                                                                return <option key={product.Id} value={product.Id}>{product.Code + ' - ' + product.Description}</option>
                                                            })
                                                        }
                                                    </select>
                                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                                </Form.Group>
                                            </Form.Row>
                                        </Form>

                                    </Col>
                                </Row>
                            </>
                            : null
                    }

                </DialogContent>
                <DialogActions>
                    {canCreateAndAssignBatch && radioValue === 'createbatch'
                        ?
                        <Button color="primary" type="submit" form="batch-form">Save</Button>
                        : null
                    }
                    {
                        radioValue === 'assignbatch' ?
                            <Button color="primary" onClick={handleFormSubmit}>
                                Save
                            </Button>
                            : null
                    }

                    <Button onClick={handleClose} color="danger">
                        Cancel
                    </Button>
                </DialogActions>
            </Dialog>

        </div>

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
    roomMaster: state.masterState.master as IRoomMaster[],
    batches: state.batchState as BatchState,
    permissions: state.authentication.permissions as IPermission[],
    products: state.productState.products as IProduct[]
});

export default connect(mapStateToProps)(TableView)