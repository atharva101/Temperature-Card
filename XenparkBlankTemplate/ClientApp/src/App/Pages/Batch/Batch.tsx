import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Table, Button, Modal, Alert, Spinner } from 'react-bootstrap';
import { useHistory } from 'react-router';
import { IBatch } from '../../../models/batch';
import { RootState } from '../../../store/action-types';
import { selectBatch, BatchState, fetchAllBatches } from '../../../store/batch/batch.action';
import { useSelector } from '../../../store/reducer';
import { connect, useDispatch } from 'react-redux';
import { IProduct } from '../../../models/product';
import { fetchAllProducts } from '../../../store/product/product.action';
import { approveMaster, MasterState } from '../../../store/master/master.action';
import { IPermission } from '../../../models/role';
import MaterialTable from "material-table";
import Menu from '@material-ui/core/Menu';
import MenuItem from '@material-ui/core/MenuItem';

interface IBatchProps {
    batches: BatchState;
    master: MasterState;
    products: IProduct[];
    permissions: IPermission[];
}
const Batch = (props: IBatchProps) => {
    const [batches, setBatches] = useState(props.batches.batches as IBatch[]);
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
        if (props.master.status === 'saved') {
            dispatch(fetchAllBatches());
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [props.master.status]);

    const [anchorEl, setAnchorEl] = React.useState<null | HTMLElement>(null);
    const openMenu = (event: any, row: any) => {
        dispatch(selectBatch(row.Id));
        setAnchorEl(event.currentTarget);
    }
    const handleClose = () => {
        setAnchorEl(null);
    };

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
                                        { title: 'Batch #', field: 'BatchNumber' },
                                        { title: 'Batch Size', field: 'BatchSize' },                                       
                                        {
                                            title: 'Product',
                                            field: 'ProductId',
                                            lookup: props.products.reduce(function (acc: any, cur: IProduct, i: number) {
                                                acc[cur.Id] = cur.Code + ' - ' + cur.Description;
                                                return acc;
                                            }, {})
                                        },
                                    ]}
                                    data={batches}
                                    actions={[
                                        {
                                            icon: 'menu',
                                            tooltip: 'Actions',
                                            isFreeAction: false,
                                            onClick: (event, row) => openMenu(event, row)
                                        }
                                    ]}
                                    options={{
                                        search: true,
                                        paging: false,
                                        maxBodyHeight: 400,
                                        actionsColumnIndex: -1,
                                        exportButton: true,
                                        grouping: true
                                    }}
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
                                    <MenuItem ><i className="feather icon-delete" /> &nbsp;Delete</MenuItem>
                                    : null
                            }
                            &nbsp;&nbsp;
                            {
                                canApprove && props.batches.batches.filter(x => x.Id === props.batches.selectedBatchId && !x.Approved).length > 0
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


