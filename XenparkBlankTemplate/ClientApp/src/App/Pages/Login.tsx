//https://medium.com/wesionary-team/how-to-setup-authentication-in-react-typescript-and-redux-6e2dd5616e30
import React, { useState, useEffect } from 'react';
import { Form } from 'react-bootstrap';
import './../../assets/scss/style.scss';
import authLogo from '../../assets/images/auth/auth-logo.png';
import authLogoDark from '../../assets/images/auth/img-auth-big.jpg';

import { connect } from 'react-redux';
import { loginUser } from '../../store/authentication/authentication.actions';
import { LoginInfo } from '../../models/token';
import { useHistory } from 'react-router';
const Login = (props: any) => {
    const history = useHistory();
    const [values, setValues] = useState({
        userName: '',
        password: ''
    } as LoginInfo);
    const [errors, setErrors] = useState({});
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        // Check for device login 
        const loginInfo: LoginInfo = {
            userName: 'ip',
            password: 'ip',
        };
        props.loginUser(loginInfo, history);
    }, [])

    useEffect(() => {
        if (props.UI.errors) {
            setErrors(props.UI.errors);
        }
        setLoading(props.UI.loading);
    }, [props.UI])

    const handleSubmit = (e: any) => {
        e.preventDefault();
        setLoading(true);
        //your client side validation here
        //after success validation
        const loginInfo: LoginInfo = {
            userName: values.userName,
            password: values.password,
        };
        props.loginUser(loginInfo, history);
    }
    const handleChange = (e: any) => {
        e.persist();
        setValues((values: any) => ({
            ...values,
            [e.target.name]: e.target.value
        }));
    };

    return (<>
        <div className="auth-wrapper align-items-stretch aut-bg-img">
            <div className="flex-grow-1">
                <div className="h-100 d-md-flex align-items-center auth-side-img">
                    <div className="col-sm-10 auth-content w-auto">
                        <img src={authLogo} alt="" className="img-fluid" />
                        <h1 className="text-white my-4">Welcome Back!</h1>
                        <h4 className="text-white font-weight-normal">
                            Sign in to your account to get real time stats of your plant.

                        </h4>
                    </div>
                </div>
                <div className="auth-side-form">
                    <div className=" auth-content">
                        <img src={authLogoDark} alt="" className="img-fluid mb-4 d-block d-xl-none d-lg-none" />
                        <h3 className="mb-4 f-w-400">Sign In</h3>
                        <div className="form-group fill">
                            <input type="text" name="userName" id="userName" className="form-control" placeholder="User Name"
                                onChange={handleChange} autoComplete="off" required />
                        </div>
                        <div className="form-group fill mb-4">
                            <input type="password" name="password" id="password" className="form-control" placeholder="Password"
                                onChange={handleChange} autoComplete="off" required />
                        </div>

                        <Form.Group className="text-left">
                            <Form.Check custom type="checkbox" id="supported-checkbox" label={'Save Credentials'} />
                        </Form.Group>

                        <button className="btn btn-block btn-primary mb-0" disabled={loading} onClick={handleSubmit}>{loading ? 'Signing In' : 'Sign In'}</button>

                        {/* {
                            errors ? <div className="text-center">{errors}</div> : null
                        } */}

                    </div>
                </div>
            </div>
        </div>

    </>);
};

//this map the states to our props in this functional component
const mapStateToProps = (state: any) => ({
    //user: state.user,
    UI: state.UI
});
//this map actions to our props in this functional component
const mapActionsToProps = {
    loginUser
};
export default connect(mapStateToProps, mapActionsToProps)(Login)
//export default Login;