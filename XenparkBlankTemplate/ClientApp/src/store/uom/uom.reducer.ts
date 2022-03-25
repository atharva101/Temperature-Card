import { IUOM } from "../../models/uom";
import { UOMActionTypes } from "../action-types";
import { UOMAction, UOMState } from "./uom.action";


export const uomInitialState: UOMState = {
    uoms: [], loading: false, error: '', selectedUOMId: -1
};

const uomReducer = (
    state: UOMState = uomInitialState,
    action: UOMAction
): UOMState => {
    switch (action.type) {
        case UOMActionTypes.FETCH_ALL_UOMS_INIT:
            return {
                ...state,
                loading: true,
                error: ''
            }
        case UOMActionTypes.FETCH_ALL_UOMS_SUCCESS:
            return {
                ...state,
                loading: false,
                uoms: action.payload as IUOM[],
            }
        case UOMActionTypes.FETCH_ALL_UOMS_FAILED:
            return {
                ...state,
                loading: false,
                error: action.payload as string
            }
        case UOMActionTypes.SELECT_PRODUCT:
            return {
                ...state,
                selectedUOMId: action.payload as number
            }
    }
    return state;
}

export default uomReducer