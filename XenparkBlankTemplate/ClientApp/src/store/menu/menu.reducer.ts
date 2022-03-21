import { IMenuItem } from "../../models/menu";
import { MenuActionTypes } from "../action-types";
import { MenuAction, MenuState } from "./menu.action";

export const menuInitialState: MenuState = {
    menu: [], loading: false, error: ''
};

const menuReducer = (
    state: MenuState = menuInitialState,
    action: MenuAction
): MenuState => {
    switch (action.type) {
        case MenuActionTypes.FETCH_MENU_INIT:
            return {
                ...state,
                loading: true,
                error: ''
            }
        case MenuActionTypes.FETCH_MENU_SUCCESS:
            return {
                ...state,
                loading: false,
                menu: action.payload as IMenuItem[],
            }
        case MenuActionTypes.FETCH_MENU_FAILED:
            return {
                ...state,
                loading: false,
                error: action.payload as string
            }        
    }
    return state;
}

export default menuReducer