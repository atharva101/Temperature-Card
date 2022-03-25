import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Table, Alert, Spinner, Button } from 'react-bootstrap';
import { connect, useDispatch } from 'react-redux';
import { IMaster } from '../../../../models/master';
import { RootState } from '../../../../store/action-types';
import { useSelector } from '../../../../store/reducer';
import { useHistory, useLocation } from 'react-router-dom';
import { fetchMasterData, selectMaster, MasterState, approveMaster, deleteMaster } from '../../../../store/master/master.action';
import { IPermission } from '../../../../models/role';
import { confirmAlert } from 'react-confirm-alert';

interface IMasterProps {
    master: MasterState;
    permissions: IPermission[];
}
const UOMMaster = (props: IMasterProps) => {
    const master: IMaster[] = useSelector(state => state.masterState.master);
    const history = useHistory();
    const location = useLocation();
    const dispatch = useDispatch();


    const [canApprove, setCanApprove] = useState(false);
    const [canAddEdit, setAddEdit] = useState(false);
    const [canDelete, setDelete] = useState(false);
    useEffect(() => {
        if (props.permissions && props.permissions.length > 0) {
            setCanApprove(props.permissions.filter(x => x.PermissionName === 'Approve Masters').length > 0 ? true : false);
            setAddEdit(props.permissions.filter(x => x.PermissionName === 'Add/Edit Unit Of Measure').length > 0 ? true : false);
            setDelete(props.permissions.filter(x => x.PermissionName === 'Delete Unit Of Measure').length > 0 ? true : false);
        }
    }, [props.permissions]);




    useEffect(() => {
        dispatch(fetchMasterData('uom', 0));
    }, []);




    const redirectToMaintainUser = (Id: number) => {
        dispatch(selectMaster(Id));
        history.push('/maintain-uom');
    }

    const approve = (Id: number) => {
        dispatch(approveMaster('uom', Id));
    }

    useEffect(() => {
        if (props.master.status === 'saved' || props.master.status === 'deleted') {
            dispatch(fetchMasterData('uom', 0));
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [props.master.status]);

    const deleteRec = (Id: number) => {
        dispatch(deleteMaster('uom', Id));
    }

    const deleteDialog = (Id: number) => {
        confirmAlert({
          title: 'Confirm to Delete',
          message: 'Are you sure to do this.',
          buttons: [
            {
              label: 'Yes',
              onClick: () => deleteRec(Id)
            },
            {
              label: 'No',
              onClick: () => {}
            }
          ]
        });
      };

    return (<>
        <Row>
            <Col>
                <Card>
                    <Card.Header>
                        <Card.Title as="h5">Unit Of Measure</Card.Title>
                        <div className="card-header-right p-1" style={{ 'cursor': 'pointer' }}>
                            {canAddEdit ?
                                <Button variant="success" className="btn-sm btn-round has-ripple" onClick={() => redirectToMaintainUser(-1)}>
                                    <i className="feather icon-plus" /> Add Unit Of Measure
                                </Button>
                                : null
                            }
                        </div>
                    </Card.Header>
                    <Card.Body>
                        {
                            props.master.error && props.master.error.length > 0
                                ?
                                <Alert variant="danger">
                                    Something went wrong! Please relaod the page.
                                </Alert>
                                : null
                        }

                        {
                            props.master.status === 'inprogress'
                                ?
                                <Spinner animation="border" variant="primary" />
                                :
                                <Table striped bordered hover responsive size="sm">
                                    <thead>
                                        <tr>
                                            {/* <th>
                                                Code
                                            </th> */}
                                            <th>
                                                Unit Of Measurement
                                            </th>

                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {
                                            master.map((data: IMaster) => {
                                                return <tr key={data.Id}>
                                                    {/* <td>{data.Code}</td> */}
                                                    <td>{data.Description}</td>

                                                    <td style={{ whiteSpace: 'nowrap', width: '180px' }}>
                                                        {
                                                            canAddEdit ?
                                                                <Button size="sm" variant="primary" className="btn-sm btn-round has-ripple" onClick={() => redirectToMaintainUser(data.Id)} title="Edit">
                                                                    <i className="feather icon-edit-2" />
                                                                </Button>
                                                                : null
                                                        }

                                                        &nbsp;&nbsp;
                                                        {
                                                            canDelete && !data.IsUsed
                                                                ?
                                                                <Button size="sm" variant="danger" className="btn-sm btn-round has-ripple"  onClick={() => deleteDialog(data.Id)} title="Delete">
                                                                    <i className="feather icon-delete" />
                                                                </Button>
                                                                : null
                                                        }

                                                        &nbsp;&nbsp;
                                                        {
                                                            canApprove && !data.Approved
                                                                ? <Button size="sm" variant="success" className="btn-sm btn-round has-ripple" title="Approve" onClick={() => approve(data.Id)}>
                                                                    <i className="fas fa-stamp" />
                                                                </Button>
                                                                : null
                                                        }
                                                    </td>
                                                </tr>
                                            })
                                        }
                                    </tbody>
                                </Table>
                        }
                    </Card.Body>
                </Card>
            </Col>
        </Row>
    </>);
};
const mapStateToProps = (state: RootState) => ({
    master: state.masterState as MasterState,
    permissions: state.authentication.permissions as IPermission[]
});

export default connect(mapStateToProps)(UOMMaster)


