import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Table, Alert, Spinner, Button } from 'react-bootstrap';
import { connect, useDispatch } from 'react-redux';
import { IMaster } from '../../../models/master';
import { RootState } from '../../../store/action-types';
import { useSelector } from '../../../store/reducer';
import { useHistory, useLocation } from 'react-router-dom';
import { fetchMasterData, selectMaster, MasterState, approveMaster } from '../../../store/master/master.action';
import { IPermission } from '../../../models/role';

interface IMasterProps {
    master: MasterState;
    permissions: IPermission[];
}
const Master = (props: IMasterProps) => {
    const master: IMaster[] = useSelector(state => state.masterState.master);
    const history = useHistory();
    const location = useLocation();
    const dispatch = useDispatch();

    const [screen, setScreen] = useState('');
    const [parentscreen, setparentScreen] = useState('');

    const [canApprove, setCanApprove] = useState(false);
    const [canAddEdit, setAddEdit] = useState(false);
    const [canDelete, setDelete] = useState(false);
    useEffect(() => {
        if (screen && props.permissions && props.permissions.length > 0) {
            setCanApprove(props.permissions.filter(x => x.PermissionName === 'Approve Masters').length > 0 ? true : false);
            if (screen.toLowerCase() === 'plant') {
                setAddEdit(props.permissions.filter(x => x.PermissionName === 'Add/Edit Plant').length > 0 ? true : false);
                setDelete(props.permissions.filter(x => x.PermissionName === 'Delete Plant').length > 0 ? true : false);
            }
            else if (screen.toLowerCase() === 'block') {
                setAddEdit(props.permissions.filter(x => x.PermissionName === 'Add/Edit Block').length > 0 ? true : false);
                setDelete(props.permissions.filter(x => x.PermissionName === 'Delete Block').length > 0 ? true : false);
            }
            else if (screen.toLowerCase() === 'area') {
                setAddEdit(props.permissions.filter(x => x.PermissionName === 'Add/Edit Area').length > 0 ? true : false);
                setDelete(props.permissions.filter(x => x.PermissionName === 'Delete Area').length > 0 ? true : false);
            }
            else if (screen.toLowerCase() === 'room') {
                setAddEdit(props.permissions.filter(x => x.PermissionName === 'Add/Edit Room').length > 0 ? true : false);
                setDelete(props.permissions.filter(x => x.PermissionName === 'Delete Room').length > 0 ? true : false);
            }
            else if (screen.toLowerCase() === 'product') {
                setAddEdit(props.permissions.filter(x => x.PermissionName === 'Add/Edit Product').length > 0 ? true : false);
                setDelete(props.permissions.filter(x => x.PermissionName === 'Delete Product').length > 0 ? true : false);
            }
            else if (screen.toLowerCase() === 'uom') {
                setAddEdit(props.permissions.filter(x => x.PermissionName === 'Add/Edit Unit Of Measure').length > 0 ? true : false);
                setDelete(props.permissions.filter(x => x.PermissionName === 'Delete Unit Of Measure').length > 0 ? true : false);
            }
        }
    }, [props.permissions, screen]);

    useEffect(() => {
        setScreen(
            location.pathname == '/plant-master' ? 'Plant'
                : location.pathname == '/block-master' ? 'Block'
                    : location.pathname == '/area-master' ? 'Area'
                        : location.pathname == '/room-master' ? 'Room'
                            : location.pathname == '/product-master' ? 'Product'
                                : location.pathname == '/uom-master' ? 'UOM'
                                    : ''
        );
    }, []);
    useEffect(() => {
        setparentScreen(
            location.pathname == '/plant-master' ? ''
                : location.pathname == '/block-master' ? 'Plant'
                    : location.pathname == '/area-master' ? 'Block'
                        : location.pathname == '/room-master' ? 'Area'
                            : location.pathname == '/product-master' ? ''
                                : location.pathname == '/uom-master' ? ''
                                    : ''
        );
    }, []);


    useEffect(() => {
        if (location.pathname == '/plant-master') {
            dispatch(fetchMasterData('plant', 0));
        }
        else if (location.pathname == '/block-master') {
            dispatch(fetchMasterData('block', 0));
        }
        else if (location.pathname == '/area-master') {
            dispatch(fetchMasterData('area', 0));
        }
        else if (location.pathname == '/room-master') {
            dispatch(fetchMasterData('room', 0));
        }
        else if (location.pathname == '/product-master') {
            dispatch(fetchMasterData('product', 0));
        }
        else if (location.pathname == '/uom-master') {
            dispatch(fetchMasterData('uom', 0));
        }
    }, []);




    const redirectToMaintainUser = (Id: number) => {
        dispatch(selectMaster(Id));
        if (screen.toLowerCase() == 'plant')
            history.push('/maintain-plant');
        else history.push('/maintain-' + screen.toLowerCase());
    }

    const approve = (Id: number) => {
        dispatch(approveMaster(screen.toLowerCase(), Id));
    }

    useEffect(() => {
        if (props.master.status === 'saved') {
            if (location.pathname == '/plant-master') {
                dispatch(fetchMasterData('plant', 0));
            }
            else if (location.pathname == '/block-master') {
                dispatch(fetchMasterData('block', 0));
            }
            else if (location.pathname == '/area-master') {
                dispatch(fetchMasterData('area', 0));
            }
            else if (location.pathname == '/room-master') {
                dispatch(fetchMasterData('room', 0));
            }
            else if (location.pathname == '/product-master') {
                dispatch(fetchMasterData('product', 0));
            }
            else if (location.pathname == '/uom-master') {
                dispatch(fetchMasterData('uom', 0));
            }
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [props.master.status]);

    return (<>
        <Row>
            <Col>
                <Card>
                    <Card.Header>
                        <Card.Title as="h5">{screen}</Card.Title>
                        <div className="card-header-right p-1" style={{ 'cursor': 'pointer' }}>
                            {canAddEdit ?
                                <Button variant="success" className="btn-sm btn-round has-ripple" onClick={() => redirectToMaintainUser(-1)}>
                                    <i className="feather icon-plus" /> Add {screen}
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
                                            {screen !== "Area" ?
                                                <th>
                                                    {
                                                        screen === "Plant" ? "Name" : "Code"
                                                    }
                                                </th>
                                                : null
                                            }
                                            <th>
                                                {
                                                    screen === "Plant" ? "Location" :
                                                        screen === "Area" ? "Name"
                                                            : "Description"
                                                }
                                            </th>
                                            {
                                                parentscreen && parentscreen != ''
                                                    ?
                                                    <th>{parentscreen}</th>
                                                    : null
                                            }
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {
                                            master.map((data: IMaster) => {
                                                return <tr key={data.Id}>
                                                    {screen !== "Area" ?
                                                        <td>{data.Code}</td>
                                                        : null
                                                    }
                                                    <td>{data.Description}</td>

                                                    {
                                                        parentscreen && parentscreen != ''
                                                            ?                                                            
                                                                screen === "Area" ? <td>{data.ParentDescription}</td>
                                                                : <td>{data.ParentCode} - {data.ParentDescription}</td>                                                            

                                                            : null
                                                    }

                                                    <td style={{ whiteSpace: 'nowrap' }}>
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

export default connect(mapStateToProps)(Master)


