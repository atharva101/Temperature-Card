import { IBatch } from "../../models/batch";
import { BatchActionTypes } from "../action-types";
import { BatchAction, BatchState } from "./batch.action";


export const batchInitialState: BatchState = {
    batches: [], status: 'init', error: '', selectedBatchId: -1
};

const batchReducer = (
    state: BatchState = batchInitialState,
    action: BatchAction
): BatchState => {
    switch (action.type) {
        case BatchActionTypes.FETCH_ALL_BATCHES_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case BatchActionTypes.FETCH_ALL_BATCHES_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }
        case BatchActionTypes.FETCH_ALL_BATCHES_SUCCESS:
            return {
                ...state,
                status: 'done',
                batches: action.payload as IBatch[],
            }
        case BatchActionTypes.SAVE_BATCH_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case BatchActionTypes.SAVE_BATCH_SUCCESS:
            return {
                ...state,
                status: 'saved',
                error: ''
            }
        case BatchActionTypes.SAVE_BATCH_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }
        case BatchActionTypes.SELECT_BATCH:
            return {
                ...state,
                selectedBatchId: action.payload as number
            }
    }
    return state;
}

export default batchReducer