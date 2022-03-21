import { IMaster } from "../../models/master";
import { MasterActionTypes } from "../action-types";
import { MasterAction, MasterState } from "./master.action";

export const masterInitialState: MasterState = {
    master: [], status: 'init', error: '', selectedMasterId: -1, parentData: []
};

const masterReducer = (
    state: MasterState = masterInitialState,
    action: MasterAction
): MasterState => {
    switch (action.type) {
        case MasterActionTypes.FETCH_ALL_MASTER_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case MasterActionTypes.FETCH_ALL_MASTER_SUCCESS:
            return {
                ...state,
                status: 'done',
                master: action.payload as IMaster[],
            }
        case MasterActionTypes.FETCH_ALL_MASTER_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }

        case MasterActionTypes.SELECT_MASTER:
            return {
                ...state,
                selectedMasterId: action.payload as number
            }
        case MasterActionTypes.SAVE_MASTER_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case MasterActionTypes.SAVE_MASTER_SUCCESS:
            return {
                ...state,
                status: 'saved',
                error: ''
            }
        case MasterActionTypes.SAVE_MASTER_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }
        case MasterActionTypes.FETCH_ALL_PARENT_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case MasterActionTypes.FETCH_ALL_PARENT_SUCCESS:
            return {
                ...state,
                status: 'done',
                parentData: action.payload as IMaster[],
            }
        case MasterActionTypes.FETCH_ALL_PARENT_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }
        case MasterActionTypes.APPROVE_MASTER_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case MasterActionTypes.APPROVE_MASTER_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }
        case MasterActionTypes.APPROVE_MASTER_SUCCESS:
            return {
                ...state,
                status: 'saved',
                error: ''
            }
    }
    return state;
}

export default masterReducer