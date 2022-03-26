import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Table, Button, Modal, Alert, Spinner, Form } from 'react-bootstrap';
import { useHistory } from 'react-router';
import { IBatch } from '../../../models/batch';
import { RootState } from '../../../store/action-types';
import { selectBatch, BatchState, fetchAllBatches, completeSelectedBatches } from '../../../store/batch/batch.action';
import { useSelector } from '../../../store/reducer';
import { connect, useDispatch } from 'react-redux';
import { IProduct } from '../../../models/product';
import { fetchAllProducts } from '../../../store/product/product.action';
import { approveMaster, deleteMaster, MasterState } from '../../../store/master/master.action';
import { IPermission } from '../../../models/role';
import MaterialTable, { MTableToolbar } from "material-table";
import Menu from '@material-ui/core/Menu';
import MenuItem from '@material-ui/core/MenuItem';
import { confirmAlert } from 'react-confirm-alert';

interface IBatchProps {
    batches: BatchState;
    master: MasterState;
    products: IProduct[];
    permissions: IPermission[];
}
const Batch = (props: IBatchProps) => {
    const [batches, setBatches] = useState(props.batches.batches as IBatch[]);
    const [checkedBatches, setCheckedBatches] = useState(props.batches.batches as IBatch[]);
    const history = useHistory();
    const dispatch = useDispatch();

    const [canApprove, setCanApprove] = useState(false);
    const [canAddEdit, setAddEdit] = useState(false);
    const [canDelete, setDelete] = useState(false);
    useEffect(() => {
        if (props.permissions && props.permissions.length > 0) {
            setCanApprove(props.permissions.filter(x => x.PermissionName === 'Approve Masters').length > 0 ? true : false);
            setAddEdit(props.permissions.filter(x => x.PermissionName === 'Add/Edit Batch').length > 0 ? true : false);
            setDelete(props.permissions.filter(x => x.PermissionName === 'Delete Batch').length > 0 ? true : false);

        }
    }, [props.permissions]);

    useEffect(() => {
        if (props.batches.batches) {
            setBatches(props.batches.batches);
        }
    }, [props.batches.batches]);

    useEffect(() => {
        dispatch(fetchAllProducts(true));
        dispatch(fetchAllBatches());
    }, []);

    const redirectToMaintainBatch = (addNew: boolean) => {
        if (addNew) dispatch(selectBatch(-1));
        history.push('/maintain-batch');
    }

    const approve = () => {
        dispatch(approveMaster('batch', props.batches.selectedBatchId));
    }

    useEffect(() => {
        if (props.master.status === 'saved' || props.master.status === 'deleted') {
            dispatch(fetchAllBatches());
            setCheckedBatches([] as IBatch[]);
            setShowModal(false);
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [props.master.status]);

    const deleteRec = () => {
        dispatch(deleteMaster('batch', props.batches.selectedBatchId));
    }

    const deleteDialog = () => {
        confirmAlert({
          title: 'Confirm to Delete',
          message: 'Are you sure you want to delete this item?',
          buttons: [
            {
              label: 'Yes',
              onClick: () => deleteRec()
            },
            {
              label: 'No',
              onClick: () => {}
            }
          ]
        });
      };
    useEffect(() => {
        if (props.batches.status === 'completed') {
            dispatch(fetchAllBatches());
            setCheckedBatches([] as IBatch[]);
            setShowModal(false);
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [props.batches.status]);

    const [anchorEl, setAnchorEl] = React.useState<null | HTMLElement>(null);
    const openMenu = (event: any, row: any) => {
        dispatch(selectBatch(row.Id));
        setAnchorEl(event.currentTarget);
    }
    const handleClose = () => {
        setAnchorEl(null);
    };
    const gridRowSelectChange = (checkedRows: IBatch[]) => {
        setCheckedBatches(checkedRows);
    }
    const [showModal, setShowModal] = useState(false);
    const handleCloseModal = () => setShowModal(false);
    const handleShowModal = () => setShowModal(true);
    const completeBatches = () => {
        if (checkedBatches.length > 0) {
            dispatch(completeSelectedBatches(checkedBatches.map(x => x.Id).join()));
        }

    }
    return (<>
        <Row>
            <Col>
                <Card>
                    <Card.Header>
                        <Card.Title as="h5"> Manage Batch</Card.Title>
                        <div className="card-header-right p-1" style={{ 'cursor': 'pointer' }}>
                            {
                                canAddEdit ?
                                    <Button size="sm" variant="success" className="btn-sm btn-round has-ripple" onClick={() => redirectToMaintainBatch(true)}>
                                        <i className="feather icon-plus" /> Add Batch
                                    </Button>
                                    :
                                    null
                            }
                            {
                                canAddEdit ?
                                    <Button size="sm" variant="danger" className="btn-sm btn-round has-ripple" onClick={handleShowModal}>
                                        <i className="feather icon-plus" /> Complete Batch
                                    </Button>
                                    :
                                    null
                            }
                            <Modal show={showModal} onHide={handleCloseModal}>
                                <Modal.Header closeButton>
                                    <Modal.Title>Complete Batch</Modal.Title>
                                </Modal.Header>
                                <Modal.Body>
                                    <p> All completed batches will be removed permanently,</p>
                                    <p>Do you want to proceed?</p>

                                </Modal.Body>
                                <Modal.Footer>
                                    <Button size="sm" variant="secondary" onClick={handleCloseModal}>
                                        No
                                    </Button>
                                    <Button size="sm" variant="danger" onClick={completeBatches}>
                                        Yes
                                    </Button>
                                </Modal.Footer>
                            </Modal>
                        </div>
                    </Card.Header>
                    <Card.Body>
                        {
                            props.batches.error && props.batches.error.length > 0
                                ?
                                <Alert variant="danger">
                                    Something went wrong! Please relaod the page.
                                </Alert>
                                : null
                        }
                        {
                            props.batches.status === 'inprogress'
                                ?
                                <Spinner animation="border" variant="primary" />
                                :
                                <MaterialTable
                                    title=""
                                    columns={[
                                        {
                                            title: 'Batch #', field: 'BatchNumber',
                                            cellStyle: {
                                                maxWidth: 200
                                            },
                                        },

                                        {
                                            title: 'Batch Size', field: 'BatchSize',
                                            cellStyle: {
                                                maxWidth: 250
                                            },
                                            render: rowData => rowData.BatchSize && rowData.BatchSize > 0 ? rowData.BatchSize.toString() + ' ' + rowData.UOM.toString() : ''
                                        },
                                        {
                                            title: 'Product',
                                            field: 'ProductId',
                                            lookup: props.products.reduce(function (acc: any, cur: IProduct, i: number) {
                                                acc[cur.Id] = cur.Code + ' - ' + cur.Description;
                                                return acc;
                                            }, {})
                                        },
                                    ]}                                    
                                    data={batches ? batches : [] as IBatch[]}
                                    actions={[
                                        {
                                            icon: 'menu',
                                            tooltip: 'Actions',
                                            onClick: (event, row) => openMenu(event, row)
                                        }
                                    ]}
                                    options={{
                                        search: true,
                                        paging: false,
                                        maxBodyHeight: 400,
                                        actionsColumnIndex: -1,
                                        exportButton: true,
                                        grouping: true,
                                    }}
                                    onSelectionChange={(e) => { gridRowSelectChange(e) }}
                                />
                        }

                        <Menu
                            id="menu"
                            anchorEl={anchorEl}
                            keepMounted
                            open={Boolean(anchorEl)}
                            onClose={handleClose}
                        >
                            {
                                canAddEdit
                                    ?
                                    <MenuItem onClick={() => redirectToMaintainBatch(false)}><i className="feather icon-edit-2" />&nbsp;Edit</MenuItem>
                                    : null
                            }
                            &nbsp;&nbsp;
                            {
                                canDelete 
                                    ?
                                    <MenuItem onClick={() => deleteDialog()} ><i className="feather icon-delete" /> &nbsp;Delete</MenuItem>
                                    : null
                            }
                            &nbsp;&nbsp;
                            {
                                canApprove && batches && batches.filter(x => x.Id === props.batches.selectedBatchId && !x.Approved).length > 0
                                    ?
                                    <MenuItem onClick={() => approve()} ><i className="fas fa-stamp" /> &nbsp;Approve</MenuItem>

                                    : null
                            }
                        </Menu>
                    </Card.Body>
                </Card>
            </Col>
        </Row>
    </>);
};

const mapStateToProps = (state: RootState) => ({
    batches: state.batchState as BatchState,
    master: state.masterState as MasterState,
    products: state.productState.products as IProduct[],
    permissions: state.authentication.permissions as IPermission[]
});
//this map actions to our props in this functional component

export default connect(mapStateToProps)(Batch)


