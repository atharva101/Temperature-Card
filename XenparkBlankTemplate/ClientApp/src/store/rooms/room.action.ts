
import { IRoom } from "../../models/room";
import { RoomActionTypes } from "../action-types";
import axios, { AxiosResponse } from "axios";
import Config from "../../config";

export type RoomState = {
    rooms: IRoom[];
    selectedRoomId: number;
    status: 'init' | 'inprogress' | 'done' | 'failed' | 'saved';
    error: string;
}

export type RoomAction = {
    type: string;
    payload: IRoom[] | boolean | string | number;
}

type DispatchRoom = (args: RoomAction) => RoomAction

export const fetchAllRooms = () => (dispatch: DispatchRoom) => {
    dispatch({ type: RoomActionTypes.FETCH_ALL_ROOMS_INIT, payload: true });
    axios.get(Config.apiUrl + 'api/Room/GetRoomStatus')
        .then((res: AxiosResponse<IRoom[]>) => {
            dispatch({
                type: RoomActionTypes.FETCH_ALL_ROOMS_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: RoomActionTypes.FETCH_ALL_ROOMS_FAILED, payload: err });
        });
}

export const fetchRoomByDeviceIP = () => (dispatch: DispatchRoom) => {
    dispatch({ type: RoomActionTypes.FETCH_ROOM_BY_DEVICE_IP_INIT, payload: true });
    axios.get(Config.apiUrl + 'api/Room/GetRoomStatusByClientIP')
        .then((res: AxiosResponse<IRoom[]>) => {
            dispatch({
                type: RoomActionTypes.FETCH_ROOM_BY_DEVICE_IP_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: RoomActionTypes.FETCH_ROOM_BY_DEVICE_IP_FAILED, payload: err });
        });
}

export const selectRoom = (id: number) => (dispatch: DispatchRoom) => {
    dispatch({ type: RoomActionTypes.SELECT_ROOM, payload: id });
}

export const changeRoomStatus = (roomId: number, batchId: number, batchSize: number, uom: number,  statusId: number, userId: number) => (dispatch: DispatchRoom) => {
    dispatch({ type: RoomActionTypes.CHANGE_ROOM_STATUS_INIT, payload: true });
    axios.get(Config.apiUrl + 'api/Room/ChangeRoomStatus', { params: { roomId: roomId, batchId: batchId, batchSize: batchSize, uom: uom, statusId: statusId, userId: userId } })
        .then((res: AxiosResponse<number>) => {
            // let action = fetchAllRooms();
            dispatch({
                type: RoomActionTypes.CHANGE_ROOM_STATUS_SUCCESS,
                payload: res.data,
            });
        }).catch((err: Error) => {
            dispatch({ type: RoomActionTypes.CHANGE_ROOM_STATUS_FAILED, payload: err.message });
        });
}

export const assignBatch = (batchId: number, roomId: number) => (dispatch: DispatchRoom) => {
    dispatch({ type: RoomActionTypes.ASSIGN_BATCH_STATUS_INIT, payload: true });
    axios.get(Config.apiUrl + 'api/Batch/AssignBatchToRoom', { params: { batchId: batchId, roomId: roomId } })
        .then((res: AxiosResponse<number>) => {
            // let action = fetchAllRooms();
            dispatch({
                type: RoomActionTypes.ASSIGN_BATCH_STATUS_SUCCESS,
                payload: res.data,
            });
        }).catch((err: Error) => {
            dispatch({ type: RoomActionTypes.ASSIGN_BATCH_STATUS_FAILED, payload: err.message });
        });
}

export const editBatchSize = (selectedRoom: IRoom) => (dispatch: DispatchRoom) => {
    dispatch({ type: RoomActionTypes.EDIT_BATCHSIZE_INIT, payload: true });
    axios.get(Config.apiUrl + 'api/Room/EditBatchSize', {
        params: {
            roomId: selectedRoom.RoomId,
            batchId: selectedRoom.BatchId,            
            batchSize: selectedRoom.BatchSize,
            uom: selectedRoom.UOM
        }
    }).then((res: AxiosResponse<number>) => {        
        dispatch({
            type: RoomActionTypes.EDIT_BATCHSIZE_SUCCESS,
            payload: res.data,
        });
    }).catch((err: Error) => {
        dispatch({ type: RoomActionTypes.EDIT_BATCHSIZE_FAILED, payload: err.message });
    });
}