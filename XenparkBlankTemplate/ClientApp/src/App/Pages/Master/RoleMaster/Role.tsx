import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Table, Alert, Spinner, Button } from 'react-bootstrap';
import { connect, useDispatch } from 'react-redux';
import { useHistory } from 'react-router';
import { IPermission, IRole } from '../../../../models/role';
import { RootState } from '../../../../store/action-types';
import { approveMaster, deleteMaster, MasterState } from '../../../../store/master/master.action';
import { fetchAllRoles, RoleState, selectRole } from '../../../../store/role/role.action';
import MaterialTable from "material-table";
import Menu from '@material-ui/core/Menu';
import MenuItem from '@material-ui/core/MenuItem';
import { confirmAlert } from 'react-confirm-alert';

interface IRoleProps {
    roles: RoleState;
    master: MasterState;
    permissions: IPermission[];
}
const Role = (props: IRoleProps) => {
    const [roles, setRoles] = useState(props.roles.roles);

    const history = useHistory();
    const dispatch = useDispatch();

    const [canAddEdit, setAddEdit] = useState(false);
    const [canDelete, setDelete] = useState(false);
    const [canApprove, setCanApprove] = useState(false);
    useEffect(() => {
        if (props.permissions && props.permissions.length > 0) {
            setCanApprove(props.permissions.filter(x => x.PermissionName === 'Approve Masters').length > 0 ? true : false);

            setAddEdit(props.permissions.filter(x => x.PermissionName === 'Add/Edit Roles and Permissions').length > 0 ? true : false);
            setDelete(props.permissions.filter(x => x.PermissionName === 'Delete Roles and Permissions').length > 0 ? true : false);
        }
    }, [props.permissions]);

    useEffect(() => {
        setRoles(props.roles.roles);
        console.log(props.roles.roles);
    }, [props.roles.roles]);


    useEffect(() => {
        dispatch(fetchAllRoles());
    }, []);




    const redirectToMaintainRole = (addNew: boolean) => {
        if (addNew) dispatch(selectRole(-1));
        history.push('/maintain-role');
    }

    const approve = () => {
        dispatch(approveMaster('role', props.roles.selectedRoleId));
    }
    useEffect(() => {
        if (props.master.status === 'saved' || props.master.status === 'deleted') {
            dispatch(fetchAllRoles());
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [props.master.status]);

    const deleteRec = () => {
        dispatch(deleteMaster('role', props.roles.selectedRoleId));
    }

    const deleteDialog = () => {
        confirmAlert({
          title: 'Confirm to Delete',
          message: 'Are you sure to do this.',
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

    const [anchorEl, setAnchorEl] = React.useState<null | HTMLElement>(null);
    const openMenu = (event: any, row: any) => {
        dispatch(selectRole(row.Id));
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
                        <Card.Title as="h5">Manage Roles & Permssion</Card.Title>
                        <div className="card-header-right p-1" style={{ 'cursor': 'pointer' }}>
                            {canAddEdit ?
                                <Button size="sm" variant="success" className="btn-sm btn-round has-ripple" onClick={() => redirectToMaintainRole(true)}>
                                    <i className="feather icon-plus" /> Add Role
                                </Button>
                                : null
                            }
                        </div>
                    </Card.Header>
                    <Card.Body>
                        {
                            props.roles.error && props.roles.error.length > 0
                                ?
                                <Alert variant="danger">
                                    Something went wrong! Please relaod the page.
                                </Alert>
                                :
                                null
                        }
                        {
                            props.roles.status === 'inprogress'
                                ?
                                <Spinner animation="border" variant="primary" />
                                :
                                <MaterialTable
                                    title=""
                                    columns={[
                                        { title: 'Name', field: 'Name' },
                                        { title: 'Description', field: 'Description' }
                                    ]}
                                    data={roles}
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
                            // <Table striped bordered hover responsive size="sm">
                            //     <thead>
                            //         <tr>
                            //             <th>Name</th>
                            //             <th>Description</th>
                            //             <th>Actions</th>
                            //         </tr>
                            //     </thead>
                            //     <tbody>
                            //         {
                            //             roles && roles.length > 0 &&
                            //             roles.map((role: IRole) => {
                            //                 return <tr key={role.Id}>
                            //                     <td>{role.Name}</td>
                            //                     <td>{role.Description}</td>
                            //                     <td style={{ whiteSpace: 'nowrap' }}>
                            //                         {
                            //                             canAddEdit ?
                            //                                 <Button size="sm" variant="primary" className="btn-sm btn-round has-ripple" onClick={() => redirectToMaintainRole(role.Id)} title="Edit">
                            //                                     <i className="feather icon-edit-2" />
                            //                                 </Button>
                            //                                 : null
                            //                         }

                            //                         &nbsp;&nbsp;
                            //                         {
                            //                             canDelete ?
                            //                                 <Button size="sm" variant="danger" className="btn-sm btn-round has-ripple" title="Delete" >
                            //                                     <i className="feather icon-delete" />
                            //                                 </Button>
                            //                                 : null
                            //                         }

                            //                         &nbsp;&nbsp;
                            //                         {
                            //                             canApprove && !role.Approved
                            //                                 ? <Button size="sm" variant="success" className="btn-sm btn-round has-ripple" title="Approve" onClick={() => approve(role.Id)}>
                            //                                     <i className="fas fa-stamp" />
                            //                                 </Button>
                            //                                 : null
                            //                         }
                            //                     </td>
                            //                 </tr>
                            //             })
                            //         }
                            //     </tbody>
                            // </Table>
                            // Role Table Here
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
                                    <MenuItem onClick={() => redirectToMaintainRole(false)}><i className="feather icon-edit-2" />&nbsp;Edit</MenuItem>
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
                                canApprove && props.roles.roles.filter(x => x.Id === props.roles.selectedRoleId && !x.Approved).length > 0
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
    roles: state.roleState as RoleState,
    master: state.masterState as MasterState,
    permissions: state.authentication.permissions as IPermission[]
});
//this map actions to our props in this functional component

export default connect(mapStateToProps)(Role)