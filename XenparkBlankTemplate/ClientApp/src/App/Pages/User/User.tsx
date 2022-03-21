import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Alert, Spinner, Button } from 'react-bootstrap';
import { connect, useDispatch } from 'react-redux';
import { RootState } from '../../../store/action-types';
import { useHistory } from 'react-router-dom';
import MaterialTable from "material-table";
import { fetchAllUsers, selectUser, UserState } from '../../../store/user/user.action';
import { IPermission, IRole } from '../../../models/role';
import { fetchAllRoles } from '../../../store/role/role.action';
import { useSelector } from '../../../store/reducer';
import Menu from '@material-ui/core/Menu';
import MenuItem from '@material-ui/core/MenuItem';


interface IUserProps {
    users: UserState;
    permissions: IPermission[];
}

const User = (props: IUserProps) => {

    const [users, setUsers] = useState(props.users.users);

    const [canAddEdit, setAddEdit] = useState(false);
    const [canDelete, setDelete] = useState(false);

    const history = useHistory();
    const dispatch = useDispatch();
    const roleList = useSelector((state) => state.roleState.roles);

    useEffect(() => {
        setUsers(props.users.users);
    }, [props.users.users]);

    useEffect(() => {
        if (props.permissions && props.permissions.length > 0) {
            setAddEdit(props.permissions.filter(x => x.PermissionName === 'Add/Edit Users').length > 0 ? true : false);
            setDelete(props.permissions.filter(x => x.PermissionName === 'Delete Users').length > 0 ? true : false);
        }
    }, [props.permissions]);

    useEffect(() => {
        dispatch(fetchAllRoles());
        dispatch(fetchAllUsers());
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);




    const redirectToMaintainUser = (userId: number) => {
        dispatch(selectUser(userId));
        history.push('/maintain-user');
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }
    const [anchorEl, setAnchorEl] = React.useState<null | HTMLElement>(null);
    const openMenu = (event: any, row: any) => {
        dispatch(selectUser(row.Id));
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
                        <Card.Title as="h5">Manage Users</Card.Title>
                        <div className="card-header-right p-1" style={{ 'cursor': 'pointer' }}>
                            {
                                canAddEdit ?
                                    <Button size="sm" variant="success" className="btn-sm btn-round has-ripple" onClick={() => redirectToMaintainUser(-1)}>
                                        <i className="feather icon-plus" /> Add User
                                    </Button>
                                    : null
                            }
                        </div>
                    </Card.Header>
                    <Card.Body className="p-0">
                        {
                            props.users.error && props.users.error.length > 0
                                ?
                                <Alert variant="danger">
                                    Something went wrong! Please relaod the page.
                                </Alert>
                                : null
                        }
                        {
                            props.users.status === 'inprogress'
                                ?
                                <Spinner animation="border" variant="primary" />
                                :
                                <MaterialTable
                                    title=""
                                    columns={[
                                        { title: 'First Name', field: 'FirstName' },
                                        { title: 'Last Name', field: 'LastName' },
                                        { title: 'Email', field: 'Email' },
                                        { title: 'User Name', field: 'UserName' },
                                        {
                                            title: 'Role',
                                            field: 'RoleId',
                                            lookup: roleList.reduce(function (acc: any, cur: IRole, i: number) {
                                                acc[cur.Id] = cur.Name;
                                                return acc;
                                            }, {})
                                        },
                                    ]}
                                    data={users}
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
                            id="simple-menu"
                            anchorEl={anchorEl}
                            keepMounted
                            open={Boolean(anchorEl)}
                            onClose={handleClose}
                        >
                            {
                                canAddEdit
                                    ?
                                    <MenuItem onClick={() => history.push('/maintain-user')}><i className="feather icon-edit-2" />&nbsp;Edit</MenuItem>
                                    : null
                            }
                            &nbsp;&nbsp;
                            {
                                canDelete
                                    ?
                                    <MenuItem ><i className="feather icon-delete" /> &nbsp;Delete</MenuItem>
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
    users: state.userState as UserState,
    //roles: state.roleState.roles as IRole[],
    permissions: state.authentication.permissions as IPermission[]
});
export default connect(mapStateToProps)(User)