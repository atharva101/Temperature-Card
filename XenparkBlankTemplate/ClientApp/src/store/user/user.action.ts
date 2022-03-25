
import { IUser } from "../../models/user";
import { UserActionTypes } from "../action-types";
import axios, { AxiosResponse } from "axios";
import Config from "../../config";

export type UserState = {
    users: IUser[];
    selectedUserId: number;
    status: 'init' | 'inprogress' | 'done' | 'failed' | 'saved';
    error: string;
}

export type UserAction = {
    type: string;
    payload: IUser[] | IUser | boolean | string | number;
}

type DispatchUser = (args: UserAction) => UserAction

export const fetchAllUsers = () => (dispatch: DispatchUser) => {
    dispatch({ type: UserActionTypes.FETCH_ALL_USERS_INIT, payload: true });
    axios.get(Config.apiUrl + 'api/User/GetUsers')
        .then((res: AxiosResponse<IUser[]>) => {
            dispatch({
                type: UserActionTypes.FETCH_ALL_USERS_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: UserActionTypes.FETCH_ALL_USERS_FAILED, payload: err });
        });
}
export const selectUser = (id: number) => (dispatch: DispatchUser) => {
    dispatch({ type: UserActionTypes.SELECT_USER, payload: id });
}

export const saveUser = (user: IUser) => (dispatch: DispatchUser): boolean => {
    dispatch({ type: UserActionTypes.SAVE_USER_INIT, payload: user });
    axios.post(Config.apiUrl + 'api/User/AddEditUser', user)
        .then((res: AxiosResponse<number>) => {
            dispatch({
                type: UserActionTypes.SAVE_USER_SUCCESS,
                payload: res.data,
            });
            return true;
        }).catch(err => {
            dispatch({ type: UserActionTypes.SAVE_USER_FAILED, payload: err });
            return false;
        });
    return true;
}