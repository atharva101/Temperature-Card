import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Form, Button, Alert, Spinner } from 'react-bootstrap';
import { connect, useDispatch } from 'react-redux';
import { useHistory } from 'react-router';
import { IRole } from '../../../models/role';
import { IUser } from '../../../models/user';
import { RootState } from '../../../store/action-types';
import { redirect } from '../../../store/master/master.action';
import { fetchAllRoles } from '../../../store/role/role.action';


import { saveUser, selectUser, UserState } from '../../../store/user/user.action';

interface IMaintainUserProps {
    users: UserState;
    roles: IRole[];
}
const MaintainUser = (props: IMaintainUserProps) => {
    const [isEdit, setIsEdit] = useState(false);

    const [user, setUser] = useState({} as IUser);
    const history = useHistory();
    const dispatch = useDispatch();

    useEffect(() => {
        dispatch(fetchAllRoles(true));
    }, []);

    useEffect(() => {
        if (props.users.selectedUserId > 0) {
            setIsEdit(true);
            const tempUser = props.users.users.find(x => x.Id === props.users.selectedUserId);
            if (tempUser) {
                setUser(tempUser);
            }
        }
        else setIsEdit(false);
    }, [props.users.selectedUserId, props.users.users]);

    useEffect(() => {
        if (props.users.status === 'saved')
            dispatch(redirect(history, '/user'));
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [props.users.status]);

    const [validated, setValidated] = useState(false);
    const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();
        const form = event.currentTarget;
        if (form.checkValidity() === false) {

            event.stopPropagation();
        }
        setValidated(true);
        dispatch(saveUser(user));

    };

    const handleInputChanges = (e: React.ChangeEvent<HTMLInputElement>) => {
        e.preventDefault();
        const { name, value } = e.target;
        setUser({
            ...user,
            [name]: value,
        });

    }
    const handleSelectChanges = (e: any) => {
        e.preventDefault();
        const { name, value } = e.target;
        setUser({
            ...user,
            [name]: value,
        });
    }
    const redirectToUserList = () => {
        dispatch(selectUser(-1));
        history.push('/user');
    }
    return (<>
        <Row>
            <Col>
                <Card>
                    <Card.Header>
                        <Card.Title as="h5"><i className="feather icon-arrow-left p-r-5" onClick={() => redirectToUserList()} /> {isEdit ? 'Edit User' : 'Add User'}</Card.Title>
                    </Card.Header>
                    <Card.Body>
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
                                <Form noValidate validated={validated} onSubmit={handleSubmit}>
                                    <Form.Row>
                                        <Form.Group as={Col} md="6" >
                                            <Form.Label>First name</Form.Label>
                                            <Form.Control
                                                required
                                                type="text"
                                                placeholder="First name"
                                                name="FirstName"
                                                defaultValue={user.FirstName}
                                                onChange={handleInputChanges}
                                            />
                                            <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                        </Form.Group>
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Last name</Form.Label>
                                            <Form.Control
                                                required
                                                type="text"
                                                placeholder="Last name"
                                                name="LastName"
                                                defaultValue={user.LastName}
                                                onChange={handleInputChanges}
                                            />
                                            <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                        </Form.Group>
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Email</Form.Label>
                                            <Form.Control type="text" placeholder="Email" name="Email" required
                                                defaultValue={user.Email}
                                                onChange={handleInputChanges}
                                            />
                                            <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                        </Form.Group>
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Username</Form.Label>
                                            <Form.Control
                                                type="text"
                                                placeholder="Username"
                                                name="UserName"
                                                required
                                                defaultValue={user.UserName}
                                                onChange={handleInputChanges}
                                            />
                                            <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                        </Form.Group>
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>Role</Form.Label>
                                            <select value={user.RoleId ?? -1} className="form-control" name="RoleId"
                                                onChange={handleSelectChanges}>
                                                <option value="">--Select--</option>
                                                <option value="1">Manager</option>
                                                <option value="2">Supervisor</option>
                                                <option value="3">Operator</option>
                                                <option value="4">Admin</option>
                                            </select>
                                            <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                        </Form.Group>
                                    </Form.Row>

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
    users: state.userState as UserState,
    roles: state.roleState.roles as IRole[]
});

export default connect(mapStateToProps)(MaintainUser)
