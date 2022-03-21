import { MenuActionTypes } from "../action-types";
import axios, { AxiosResponse } from "axios";
import Config from "../../config";
import { IMenuItem } from "../../models/menu";

export type MenuState = {
    menu: IMenuItem[];
    loading: boolean;
    error: string;
}

export type MenuAction = {
    type: string;
    payload: IMenuItem[] | boolean | string | number;
}
type DispatchMenu = (args: MenuAction) => MenuAction


export const fetchMenus = () => (dispatch: DispatchMenu) => {
    dispatch({ type: MenuActionTypes.FETCH_MENU_INIT, payload: true });

    axios.get(Config.apiUrl + 'api/Master/GetMenus')
        .then((res: AxiosResponse<IMenuItem[]>) => {
            dispatch({
                type: MenuActionTypes.FETCH_MENU_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: MenuActionTypes.FETCH_MENU_FAILED, payload: err });
        });
}