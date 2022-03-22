import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Form, Button, Alert, Spinner } from 'react-bootstrap';
import { connect, useDispatch } from 'react-redux';
import { useHistory } from 'react-router';
import { IPermission, IPermissionGroup, IRole, RolePermission } from '../../../../models/role';
import { RootState } from '../../../../store/action-types';
import { fetchAllPermissions, RoleState, saveRole, selectRole } from '../../../../store/role/role.action';

interface IMaintainRoleProps {
    roles: RoleState;
    saveRole: any
}
interface IPermissionProps {
    permissions: PermissionState;
}

const MaintainRole = (props: IMaintainRoleProps) => {
    const [isEdit, setIsEdit] = useState(false);

    const [role, setRole] = useState({} as IRole);
    const [roleP, setRoleP] = useState({} as RolePermission);
    const [permissionGroups, setPermissionGroup] = useState([] as IPermissionGroup[]);
    console.log()
    const history = useHistory();
    const dispatch = useDispatch();

    useEffect(() => {
        dispatch(fetchAllPermissions());
    }, []);

    useEffect(() => {
        if (isEdit && role.RolePermission && props.roles.permissions && props.roles.permissions.length > 0) {

            const perm = props.roles.permissions
                .map((x) => {
                    return {
                        ...x, checked: (role.RolePermission.filter(p => p.PermissionId == x.Id).length > 0) ? true : false
                    }
                });
            console.log(perm);
            setPermissionGroup(
                JSON.parse(JSON.stringify(
                    perm.map(item => item.GroupName)
                        .filter((value, index, self) => self.indexOf(value) === index)
                        .map((x) => {
                            return {
                                GroupName: x,
                                Permission: perm.filter(p => p.GroupName === x)
                            } as IPermissionGroup

                        })
                ))
            );

        }

        else {
            setPermissionGroup(
                props.roles.permissions.map(item => item.GroupName)
                    .filter((value, index, self) => self.indexOf(value) === index)
                    .map((x) => {
                        return {
                            GroupName: x,
                            Permission: props.roles.permissions.filter(p => p.GroupName === x)
                        } as IPermissionGroup
                    })

            );
        }
    }, [props.roles.permissions, role]);

    useEffect(() => {
        if (props.roles.selectedRoleId > 0) {
            setIsEdit(true);
            const tempRole = props.roles.roles.find(x => x.Id === props.roles.selectedRoleId);
            if (tempRole) {
                setRole(tempRole);
            }
        }
        else setIsEdit(false);

    }, [props.roles.selectedRoleId, props.roles.roles]);


    const [validated, setValidated] = useState(false);
    const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();
        const form = event.currentTarget;

        if (form.checkValidity() === false) {

            event.stopPropagation();
        }
        setValidated(true);
        dispatch(saveRole(role));
    };

    useEffect(() => {
        if (props.roles.status === 'saved') {
            history.push('/role');
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [props.roles.status]);

    const handleInputChanges = (e: React.ChangeEvent<HTMLInputElement>) => {
        e.preventDefault();
        const { name, value } = e.target;
        setRole({
            ...role,
            [name]: value,
        });

    }
    const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        e.persist();
        const permission = role.RolePermission ? role.RolePermission : [];
        if (e.target.checked && permission.map(x => x.PermissionId).indexOf(parseInt(e.target.value)) < 0)
            permission.push({ Id: -1, RoleId: role.Id, PermissionId: parseInt(e.target.value) })
        else {
            const index = permission.findIndex(x => x.PermissionId == parseInt(e.target.value));
            if (index > -1)
                permission.splice(index, 1);
        }

        setRole(
            {
                ...role,
                RolePermission: permission
            }
        )
    };
    const redirectToRoleList = () => {
        dispatch(selectRole(-1));
        history.push('/role');
    }
    return (<>
        <Row>
            <Col>
                <Card>
                    <Card.Header>
                        <Card.Title as="h5"><i className="feather icon-arrow-left p-r-5" onClick={() => redirectToRoleList()} /> {isEdit ? 'Edit Role' : 'Add Role'}</Card.Title>
                    </Card.Header>
                    <Card.Body>
                        {
                            props.roles.error && props.roles.error.length > 0
                                ?
                                <Alert variant="danger">
                                    {props.roles.error}
                                </Alert>
                                : null
                        }
                        {
                            props.roles.status === 'inprogress'
                                ?
                                <Spinner animation="border" variant="primary" />
                                :
                                <Form noValidate validated={validated} onSubmit={handleSubmit}>
                                    <Form.Row>
                                        <Form.Group as={Col} md="6" >
                                            <Form.Label>Name</Form.Label>
                                            <Form.Control
                                                required
                                                type="text"
                                                placeholder="Name"
                                                name="Name"
                                                defaultValue={role.Name}
                                                onChange={handleInputChanges}
                                            />
                                            <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                        </Form.Group>
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Description</Form.Label>
                                            <Form.Control
                                                required
                                                type="text"
                                                placeholder="Description"
                                                name="Description"
                                                defaultValue={role.Description}
                                                onChange={handleInputChanges}
                                            />
                                            <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                        </Form.Group>
                                    </Form.Row>
                                    <h4>Permissions</h4>
                                    {
                                        permissionGroups.map((group, i) => {
                                            return <div key={i} className="mb-3">
                                                <h6 >{group.GroupName}</h6>

                                                {
                                                    group.Permission.map((permission, index) => {

                                                        return <Form.Check
                                                            inline
                                                            key={index}
                                                            type='checkbox'
                                                            id={`chk-${permission.Id}`}
                                                            defaultChecked={permission.checked}
                                                            label={permission.PermissionName}
                                                            onChange={handleChange}
                                                            value={permission.Id}
                                                        />


                                                    })
                                                }

                                            </div>
                                        })
                                    }
                                    <Button type="submit">Submit form</Button>
                                </Form>
                        }
                    </Card.Body>
                </Card>
            </Col>
        </Row>

    </>);
};
const mapStateToProps = (state: RootState) => ({
    roles: state.roleState as RoleState,
});

export default connect(mapStateToProps)(MaintainRole);