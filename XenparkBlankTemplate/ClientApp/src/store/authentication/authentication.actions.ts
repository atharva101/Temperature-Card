import axios, { AxiosResponse } from "axios";
import Config from "../../config";
import { encrypt } from "../../helpers/encrypt";
import { IPermission } from "../../models/role";
import { LoginInfo, Token } from "../../models/token";
import { IUser } from "../../models/user";
import { CLEAR_ERRORS, FETCH_USERPERMISSIONS_FAILED, FETCH_USERPERMISSIONS_INIT, FETCH_USERPERMISSIONS_SUCCESS, LOADING_UI, LOADING_USER, SET_ERRORS, SET_UNAUTHENTICATED, SET_USER } from "../action-types";

export type AuthenticationState = {
    authenticated: boolean,
    loggedInUser: IUser,
    permissions: IPermission[]
    loading: boolean
}

export const loginUser = (loginInfo: LoginInfo, history: any) => (dispatch: any) => {
    dispatch({ type: LOADING_UI })
    axios.post(Config.apiUrl + 'api/User/Authenticate', { UserName: loginInfo.userName, Password: encrypt(loginInfo.password) })
        .then((res: AxiosResponse<Token>) => {
            if (res.data.access_token) {
                localStorage.setItem('access_token', `Bearer ${res.data.access_token}`);//setting token to local storage
                axios.defaults.headers.common['Authorization'] = `Bearer ${res.data.access_token}`;//setting authorize token to header in axios
                dispatch(getUserData());
                dispatch(getUserPermissions());
                dispatch({ type: CLEAR_ERRORS });
            } else {
                dispatch({
                    type: SET_ERRORS,
                    payload: 'Something went wrong'
                });
            }
        })
        .catch((err) => {
            dispatch({
                type: SET_ERRORS,
                payload: err.response.data
            });
        });
}

//for fetching authenticated user information
export const getUserData = () => (dispatch: any) => {
    dispatch({ type: LOADING_USER });
    axios.get(Config.apiUrl + 'api/User/Me')
        .then((res: AxiosResponse<IUser>) => {
            dispatch({
                type: SET_USER,
                payload: res.data
            });
        }).catch(err => {
        });
}

export const getUserPermissions = () => (dispatch: any) => {
    dispatch({ type: FETCH_USERPERMISSIONS_INIT });
    axios.get(Config.apiUrl + 'api/Role/GetUserPermissions')
        .then((res: AxiosResponse<IPermission>) => {
            dispatch({
                type: FETCH_USERPERMISSIONS_SUCCESS,
                payload: res.data
            });
        }).catch(err => {
            dispatch({ type: FETCH_USERPERMISSIONS_FAILED, payload: err });
        });
}



export const logoutUser = () => (dispatch: any) => {
    localStorage.removeItem('access_token');
    delete axios.defaults.headers.common['Authorization']
    dispatch({
        type: SET_UNAUTHENTICATED
    });
    window.location.href = '/login'; // redirect to login page
};