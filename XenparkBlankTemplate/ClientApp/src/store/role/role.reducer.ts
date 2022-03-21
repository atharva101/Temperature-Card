import { IPermission, IRole } from "../../models/role";
import { RoleActionTypes } from "../action-types";
import { RoleAction, RoleState } from "./role.action";

export const roleInitialState: RoleState = {
    roles: [], permissions: [], status: 'init', error: '', selectedRoleId: 0
};

const roleReducer = (
    state: RoleState = roleInitialState,
    action: RoleAction
): RoleState => {
    switch (action.type) {
        case RoleActionTypes.FETCH_ROLES_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case RoleActionTypes.FETCH_ROLES_SUCCESS:
            return {
                ...state,
                status: 'done',
                roles: action.payload as IRole[],
            }
        case RoleActionTypes.FETCH_ROLES_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }
        case RoleActionTypes.SELECT_ROLE:
            return {
                ...state,
                selectedRoleId: action.payload as number
            }
        case RoleActionTypes.SAVE_ROLE_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case RoleActionTypes.SAVE_ROLE_SUCCESS:
            return {
                ...state,
                status: 'saved',
                error: ''
            }
        case RoleActionTypes.SAVE_ROLE_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }
        case RoleActionTypes.FETCH_PERMISSIONS_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case RoleActionTypes.FETCH_PERMISSIONS_SUCCESS:
            return {
                ...state,
                status: 'done',
                permissions: action.payload as IPermission[],
            }
        case RoleActionTypes.FETCH_PERMISSIONS_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }
    }
    return state;
}

export default roleReducer