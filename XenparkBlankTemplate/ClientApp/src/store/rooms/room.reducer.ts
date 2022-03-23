import { IRoom } from "../../models/room";
import { RoomActionTypes } from "../action-types";
import { RoomAction, RoomState } from "./room.action";


export const roomInitialState: RoomState = {
    rooms: [], status: 'init', error: '', selectedRoomId: -1
};

const roomReducer = (
    state: RoomState = roomInitialState,
    action: RoomAction
): RoomState => {
    switch (action.type) {
        case RoomActionTypes.FETCH_ALL_ROOMS_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case RoomActionTypes.FETCH_ALL_ROOMS_SUCCESS:
            return {
                ...state,
                status: 'done',
                rooms: action.payload as IRoom[],
            }
        case RoomActionTypes.FETCH_ALL_ROOMS_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }
            case RoomActionTypes.ASSIGN_BATCH_STATUS_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case RoomActionTypes.ASSIGN_BATCH_STATUS_SUCCESS:
            return {
                ...state,
                status: 'saved',
                rooms: action.payload as IRoom[],
            }
        case RoomActionTypes.ASSIGN_BATCH_STATUS_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }
        case RoomActionTypes.SELECT_ROOM:
            return {
                ...state,
                status: 'done',
                selectedRoomId: action.payload as number
            }
        case RoomActionTypes.FETCH_ROOM_BY_DEVICE_IP_INIT:
            return {
                ...state,
                status: 'inprogress',
                error: ''
            }
        case RoomActionTypes.FETCH_ROOM_BY_DEVICE_IP_SUCCESS:
            return {
                ...state,
                status: 'done',
                rooms: action.payload as IRoom[],
            }
        case RoomActionTypes.FETCH_ROOM_BY_DEVICE_IP_FAILED:
            return {
                ...state,
                status: 'failed',
                error: action.payload as string
            }        
    }
    return state;
}

export default roomReducer