import { IMaster, IRoomMaster } from "../../models/master";
import { MasterActionTypes } from "../action-types";
import axios, { AxiosResponse } from "axios";
import Config from "../../config";

export type MasterState = {
    master: IMaster[] | IRoomMaster[];
    parentData: IMaster[];
    selectedMasterId: number;
    status: 'init' | 'inprogress' | 'done' | 'failed' | 'saved' | 'deleted';
    error: string;
}

export type MasterAction = {
    type: string;
    payload: IMaster[] | IMaster | IRoomMaster[] | boolean | string | number;
}
type DispatchMaster = (args: MasterAction) => MasterAction

export const redirect = (history: any, url: string) => (dispatch: DispatchMaster) => {
    history.push(url);
}

export const fetchMasterData = (type: string, parentId: number, approveOnly: boolean = false) => (dispatch: DispatchMaster) => {
    dispatch({ type: MasterActionTypes.FETCH_ALL_MASTER_INIT, payload: true });
    let queryString = '';
    queryString += '?type=' + type +
        '&parentId=' + parentId +
        '&approveOnly=' + approveOnly;
    axios.get(Config.apiUrl + 'api/Master/GetMasters' + queryString)
        .then((res: AxiosResponse<IMaster[]>) => {
            dispatch({
                type: MasterActionTypes.FETCH_ALL_MASTER_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: MasterActionTypes.FETCH_ALL_MASTER_FAILED, payload: err });
        });
}

export const fetchRoomMasterData = () => (dispatch: DispatchMaster) => {
    dispatch({ type: MasterActionTypes.FETCH_ALL_MASTER_INIT, payload: true });

    axios.get(Config.apiUrl + 'api/Master/GetRoomMaster')
        .then((res: AxiosResponse<IRoomMaster[]>) => {
            dispatch({
                type: MasterActionTypes.FETCH_ALL_MASTER_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: MasterActionTypes.FETCH_ALL_MASTER_FAILED, payload: err });
        });
}


export const selectMaster = (id: number) => (dispatch: DispatchMaster) => {
    dispatch({ type: MasterActionTypes.SELECT_MASTER, payload: id });
}

export const saveMaster = (type: string, master: IMaster) => (dispatch: DispatchMaster) => {
    let queryString = '';
    queryString += '?type=' + type;
    dispatch({ type: MasterActionTypes.SAVE_MASTER_INIT, payload: master });
    axios.post(Config.apiUrl + 'api/Master/AddEditMaster' + queryString, master)
        .then((res: AxiosResponse<number>) => {
            if (res.data == 101) {
                dispatch({
                    type: MasterActionTypes.SAVE_MASTER_SUCCESS,
                    payload: res.data,
                });
            }
            else if (res.data === -101) {
                dispatch({
                    type: MasterActionTypes.SAVE_MASTER_FAILED,
                    payload: type === 'plant' ? 'Plant Name-Location should be unique'
                        : type === 'block' ? 'Block already exists in plant !'
                            : type === 'area' ? 'Area already exists in plant !'
                                : type === 'room' ? 'Room already exists in selected area !'
                                    : type === 'product' ? 'Product already exists !'
                                        : type === 'uom' ? 'Unit of measurement already exists !'
                                            : 'Something went wrong. Please try again !'
                });
            }
            else if (res.data === -102) {
                dispatch({
                    type: MasterActionTypes.SAVE_MASTER_FAILED,
                    payload: type === 'room' ? 'Device IP already exists !'
                                            : 'Something went wrong. Please try again !'
                });
            } else {
                dispatch({
                    type: MasterActionTypes.SAVE_MASTER_FAILED,
                    payload: 'Something went wrong. Please try again.'
                })
            }

        }).catch(err => {
            dispatch({ type: MasterActionTypes.SAVE_MASTER_FAILED, payload: err });
        });
}

export const fetchParentData = (type: string, approveOnly: boolean = false) => (dispatch: DispatchMaster) => {
    dispatch({ type: MasterActionTypes.FETCH_ALL_PARENT_INIT, payload: true });
    let queryString = '';
    queryString += '?type=' + type +
        '&approveOnly=' + approveOnly;
    axios.get(Config.apiUrl + 'api/Master/GetParentData' + queryString)
        .then((res: AxiosResponse<IMaster[]>) => {
            dispatch({
                type: MasterActionTypes.FETCH_ALL_PARENT_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: MasterActionTypes.FETCH_ALL_PARENT_FAILED, payload: err });
        });
}

export const approveMaster = (type: string, id: number) => (dispatch: DispatchMaster) => {
    dispatch({ type: MasterActionTypes.APPROVE_MASTER_INIT, payload: true });
    let queryString = '';
    queryString += '?type=' + type +
        '&Id=' + id;

    axios.get(Config.apiUrl + 'api/Master/ApproveMaster' + queryString)
        .then((res: AxiosResponse<number>) => {
            dispatch({
                type: MasterActionTypes.APPROVE_MASTER_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: MasterActionTypes.APPROVE_MASTER_FAILED, payload: err });
        });
}

export const deleteMaster = (type: string, id: number) => (dispatch: DispatchMaster) => {
    dispatch({ type: MasterActionTypes.DELETE_MASTER_INIT, payload: true });
    let queryString = '';
    queryString += '?type=' + type +
        '&Id=' + id;

    axios.get(Config.apiUrl + 'api/Master/DeleteMaster' + queryString)
        .then((res: AxiosResponse<number>) => {
            if (res) {
                dispatch({
                    type: MasterActionTypes.DELETE_MASTER_SUCCESS,
                    payload: res.data,
                });
            }
            else {
                dispatch({
                    type: MasterActionTypes.DELETE_MASTER_FAILED,
                    payload: 'Something went wrong. Please try again.',
                });
            }
            
        }).catch(err => {
            dispatch({ type: MasterActionTypes.DELETE_MASTER_FAILED, payload: err });
        });
}

