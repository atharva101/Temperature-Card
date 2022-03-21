
import { IBatch } from "../../models/batch";
import { BatchActionTypes } from "../action-types";
import axios, { AxiosResponse } from "axios";
import Config from "../../config";

export type BatchState = {
    batches: IBatch[];
    selectedBatchId: number;
    status: 'init' | 'inprogress' | 'done' | 'failed' | 'saved';
    error: string;
}

export type BatchAction = {
    type: string;
    payload: IBatch[] | IBatch | boolean | string | number;
}

type DispatchBatch = (args: BatchAction) => BatchAction

export const fetchAllBatches = (readyToAssign: boolean = false, roomId: number = 0) => (dispatch: DispatchBatch) => {
    dispatch({ type: BatchActionTypes.FETCH_ALL_BATCHES_INIT, payload: true });
    axios.get(Config.apiUrl + 'api/Batch/GetBatch', { params: { readyToAssign: readyToAssign, roomId: roomId } })
        .then((res: AxiosResponse<IBatch[]>) => {
            dispatch({
                type: BatchActionTypes.FETCH_ALL_BATCHES_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: BatchActionTypes.FETCH_ALL_BATCHES_FAILED, payload: err });
        });
}

export const selectBatch = (id: number) => (dispatch: DispatchBatch) => {
    dispatch({ type: BatchActionTypes.SELECT_BATCH, payload: id });
}

export const saveBatch = (batch: IBatch) => (dispatch: DispatchBatch) => {
    dispatch({ type: BatchActionTypes.SAVE_BATCH_INIT, payload: batch });
    axios.post(Config.apiUrl + 'api/Batch/AddEditBatch', batch)
        .then((res: AxiosResponse<number>) => {
            if (res.data == 101) {
                dispatch({
                    type: BatchActionTypes.SAVE_BATCH_SUCCESS,
                    payload: res.data,
                });
            } else if (res.data === -101) {
                dispatch({
                    type: BatchActionTypes.SAVE_BATCH_FAILED,
                    payload: 'Batch already exists.'
                });
            } else {
                dispatch({
                    type: BatchActionTypes.SAVE_BATCH_FAILED,
                    payload: 'Something went wrong. Please try again.'
                })
            }
        }).catch(err => {
            dispatch({ type: BatchActionTypes.SAVE_BATCH_FAILED, payload: err });
        });
}