
import { IUOM } from "../../models/uom";
import { UOMActionTypes } from "../action-types";
import axios, { AxiosResponse } from "axios";
import Config from "../../config";

export type UOMState = {
    uoms: IUOM[];
    selectedUOMId: number;
    loading: boolean;
    error: string;
}

export type UOMAction = {
    type: string;
    payload: IUOM[] | boolean | string | number;
}

type DispatchUOM = (args: UOMAction) => UOMAction

export const fetchAllUOMs = (approveOnly: boolean = false) => (dispatch: DispatchUOM) => {
    dispatch({ type: UOMActionTypes.FETCH_ALL_UOMS_INIT, payload: true });
    let queryString = '';
    queryString += '?type=uom' +
        '&approveOnly=' + approveOnly;
    axios.get(Config.apiUrl + 'api/Master/GetMasters' + queryString)
        .then((res: AxiosResponse<IUOM[]>) => {
            dispatch({
                type: UOMActionTypes.FETCH_ALL_UOMS_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: UOMActionTypes.FETCH_ALL_UOMS_FAILED, payload: err });
        });
}
export const selectUOM = (id: number) => (dispatch: DispatchUOM) => {
    dispatch({ type: UOMActionTypes.SELECT_PRODUCT, payload: id });
}