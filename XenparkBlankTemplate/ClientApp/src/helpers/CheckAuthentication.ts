import jwtDecode from 'jwt-decode';//you must install jwt-decode using npm
import { logoutUser, getUserData, getUserPermissions } from '../store/authentication/authentication.actions'
import store from '../store/store';
import axios from 'axios';
import { SET_AUTHENTICATED } from '../store/action-types'
export const CheckAuthentication = () => {
    const authToken = localStorage.access_token;
    if (authToken) {
        const decodedToken: any = jwtDecode(authToken);
        if (decodedToken.exp * 1000 < Date.now()) {
            store.dispatch(logoutUser());
        } else {
            store.dispatch({ type: SET_AUTHENTICATED });
            axios.defaults.headers.common['Authorization'] = authToken;
            store.dispatch(getUserData());
            store.dispatch(getUserPermissions());
        }
    }
}