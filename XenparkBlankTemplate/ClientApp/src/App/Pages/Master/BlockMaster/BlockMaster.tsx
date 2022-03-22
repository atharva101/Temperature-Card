import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Table, Alert, Spinner, Button } from 'react-bootstrap';
import { connect, useDispatch } from 'react-redux';
import { IMaster } from '../../../../models/master';
import { RootState } from '../../../../store/action-types';
import { useSelector } from '../../../../store/reducer';
import { useHistory, useLocation } from 'react-router-dom';
import { fetchMasterData, selectMaster, MasterState, approveMaster } from '../../../../store/master/master.action';
import { IPermission } from '../../../../models/role';

interface IMasterProps {
    master: MasterState;
    permissions: IPermission[];
}
const BlockMaster = (props: IMasterProps) => {
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
            setAddEdit(props.permissions.filter(x => x.PermissionName === 'Add/Edit Block').length > 0 ? true : false);
            setDelete(props.permissions.filter(x => x.PermissionName === 'Delete Block').length > 0 ? true : false);
        }
    }, [props.permissions]);




    useEffect(() => {
        dispatch(fetchMasterData('block', 0));
    }, []);




    const redirectToMaintainUser = (Id: number) => {
        dispatch(selectMaster(Id));
        history.push('/maintain-block');
    }

    const approve = (Id: number) => {
        dispatch(approveMaster('block', Id));
    }

    useEffect(() => {
        if (props.master.status === 'saved') {
            dispatch(fetchMasterData('block', 0));
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [props.master.status]);

    return (<>
        <Row>
            <Col>
                <Card>
                    <Card.Header>
                        <Card.Title as="h5">Block</Card.Title>
                        <div className="card-header-right p-1" style={{ 'cursor': 'pointer' }}>
                            {canAddEdit ?
                                <Button variant="success" className="btn-sm btn-round has-ripple" onClick={() => redirectToMaintainUser(-1)}>
                                    <i className="feather icon-plus" /> Add Block
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
                                            <th>
                                                Name
                                            </th>
                                            <th>Reference Number</th>
                                            <th>Form Number</th>
                                            <th>Version Number</th>
                                            <th>Plant</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {
                                            master.map((data: IMaster) => {
                                                return <tr key={data.Id}>                                                    
                                                    <td>{data.Description}</td>
                                                    <td>{data.Column1}</td>
                                                    <td>{data.Column2}</td>
                                                    <td>{data.Column3}</td>
                                                    <td>{data.ParentCode} - {data.ParentDescription}</td>

                                                    <td style={{ whiteSpace: 'nowrap',width:'180px' }}>
                                                        {
                                                            canAddEdit ?
                                                                <Button size="sm" variant="primary" className="btn-sm btn-round has-ripple" onClick={() => redirectToMaintainUser(data.Id)} title="Edit">
                                                                    <i className="feather icon-edit-2" />
                                                                </Button>
                                                                : null
                                                        }

                                                        &nbsp;&nbsp;
                                                        {
                                                            canDelete
                                                                ?
                                                                <Button size="sm" variant="danger" className="btn-sm btn-round has-ripple" title="Delete">
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

export default connect(mapStateToProps)(BlockMaster)


