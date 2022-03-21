import { SET_USER, SET_AUTHENTICATED, SET_UNAUTHENTICATED, LOADING_USER, FETCH_USERPERMISSIONS_INIT, FETCH_USERPERMISSIONS_SUCCESS, FETCH_USERPERMISSIONS_FAILED } from '../action-types'
import { AuthenticationState } from './authentication.actions';

export const authInitialState: AuthenticationState = {
    authenticated: false,
    loggedInUser: {
        Id: -1,
        FirstName: '',
        LastName: '',
        Email: '',
        UserName: '',
        RoleId: null,
        IsDisabled: true,
        IsDeleted: true,
        Avatar: ''
    },
    permissions: [],
    loading: false
}

const authenticationReducer = (state = authInitialState, action: any) => {
    switch (action.type) {
        case SET_AUTHENTICATED:
            return {
                ...state,
                authenticated: true
            };
        case SET_UNAUTHENTICATED:
            return authInitialState;
        case SET_USER:
            return {
                authenticated: true,
                loading: false,
                loggedInUser: action.payload
            };
        case LOADING_USER || FETCH_USERPERMISSIONS_INIT:
            return {
                ...state,
                loading: true
            };
        case FETCH_USERPERMISSIONS_SUCCESS:
            return {
                ...state,
                loading: false,
                permissions: action.payload
            };
        case FETCH_USERPERMISSIONS_FAILED:
            return {
                ...state,
                loading: false
            };
        default:
            return state;
    }
}

export default authenticationReducer;