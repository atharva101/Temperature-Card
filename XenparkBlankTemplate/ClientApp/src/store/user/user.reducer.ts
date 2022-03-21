import { IUser } from "../../models/user";
import { UserActionTypes } from "../action-types";
import { UserAction, UserState } from "./user.action";


export const userInitialState: UserState = {
    users: [], status: 'init', error: '', selectedUserId: -1
};

const userReducer = (
    state: UserState = userInitialState,
    action: UserAction
): UserState => {
    switch (action.type) {
        case UserActionTypes.FETCH_ALL_USERS_INIT || UserActionTypes.SAVE_USER_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case UserActionTypes.FETCH_ALL_USERS_SUCCESS:
            return {
                ...state,
                status: 'done',
                users: action.payload as IUser[],
            }
        case UserActionTypes.FETCH_ALL_USERS_FAILED || UserActionTypes.SAVE_USER_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }
        case UserActionTypes.SELECT_USER:
            return {
                ...state,
                selectedUserId: action.payload as number
            }
        case UserActionTypes.SAVE_USER_SUCCESS:
            return {
                ...state,
                status: 'saved',
                error: ''
            }
    }
    return state;
}

export default userReducer