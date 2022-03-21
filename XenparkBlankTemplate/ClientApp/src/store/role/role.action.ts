
import { IPermission, IRole } from "../../models/role";
import { RoleActionTypes } from "../action-types";
import axios, { AxiosResponse } from "axios";
import Config from "../../config";

export type RoleState = {
    roles: IRole[];
    permissions: IPermission[];
    selectedRoleId: number;
    status: 'init' | 'inprogress' | 'done' | 'failed' | 'saved';
    error: string;
}

export type RoleAction = {
    type: string;
    payload: IRole[] | IRole | IPermission[] | boolean | string | number;
}

type DispatchRole = (args: RoleAction) => RoleAction

export const fetchAllRoles = (approveOnly: boolean = false) => (dispatch: DispatchRole) => {
    dispatch({ type: RoleActionTypes.FETCH_ROLES_INIT, payload: true });
    axios.get(Config.apiUrl + 'api/Role/GetRoles?type=' + approveOnly)
        .then((res: AxiosResponse<IRole[]>) => {
            dispatch({
                type: RoleActionTypes.FETCH_ROLES_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: RoleActionTypes.FETCH_ROLES_FAILED, payload: err });
        });
}
export const selectRole = (id: number) => (dispatch: DispatchRole) => {
    dispatch({ type: RoleActionTypes.SELECT_ROLE, payload: id });
}

export const saveRole = (role: IRole) => (dispatch: DispatchRole) => {
    dispatch({ type: RoleActionTypes.SAVE_ROLE_INIT, payload: role });
    axios.post(Config.apiUrl + 'api/Role/MaintainRole', role)
        .then((res: AxiosResponse<number>) => {
            if (res.data == 101) {
                dispatch({
                    type: RoleActionTypes.SAVE_ROLE_SUCCESS,
                    payload: res.data,
                });
            }
            else if (res.data === -101) {
                dispatch({
                    type: RoleActionTypes.SAVE_ROLE_FAILED,
                    payload: 'Role already exists.'
                });
            } else {
                dispatch({
                    type: RoleActionTypes.SAVE_ROLE_FAILED,
                    payload: 'Something went wrong. Please try again.'
                })
            }
        }).catch(err => {
            dispatch({ type: RoleActionTypes.SAVE_ROLE_FAILED, payload: err });
        });
}

export const fetchAllPermissions = () => (dispatch: DispatchRole) => {
    dispatch({ type: RoleActionTypes.FETCH_PERMISSIONS_INIT, payload: true });
    axios.get(Config.apiUrl + 'api/Role/GetPermissions')
        .then((res: AxiosResponse<IPermission[]>) => {
            dispatch({
                type: RoleActionTypes.FETCH_PERMISSIONS_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: RoleActionTypes.FETCH_PERMISSIONS_FAILED, payload: err });
        });
}
