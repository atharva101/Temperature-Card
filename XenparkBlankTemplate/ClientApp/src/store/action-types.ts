import { BatchState } from "./batch/batch.action";
import { UserState } from "./user/user.action";
import { ProductState } from "./product/product.action";
import { RoomState } from "./rooms/room.action";
import { MasterState } from "./master/master.action";
import { MenuState } from "./menu/menu.action";
import { RoleState } from "./role/role.action";

export interface RootState {
    theme: any;
    authentication: any;
    UI: any;
    userState: UserState;
    batchState: BatchState;
    productState: ProductState;
    roomState: RoomState,
    masterState: MasterState,
    menuState: MenuState,
    roleState: RoleState
}

//authentication reducer types
export const SET_AUTHENTICATED = 'SET_AUTHENTICATED';
export const SET_UNAUTHENTICATED = 'SET_UNAUTHENTICATED';
export const SET_USER = 'SET_USER';
export const LOADING_USER = 'LOADING_USER';
//UI reducer types
export const SET_ERRORS = 'SET_ERRORS';
export const LOADING_UI = 'LOADING_UI';
export const CLEAR_ERRORS = 'CLEAR_ERRORS';

export const FETCH_USERPERMISSIONS_INIT = 'FETCH_USERPERMISSIONS_INIT';
export const FETCH_USERPERMISSIONS_SUCCESS = 'FETCH_USERPERMISSIONS_SUCCESS';
export const FETCH_USERPERMISSIONS_FAILED = 'FETCH_USERPERMISSIONS_FAILED';


export enum UserActionTypes {
    FETCH_ALL_USERS_INIT = 'FETCH_ALL_USERS_INIT',
    FETCH_ALL_USERS_SUCCESS = 'FETCH_ALL_USERS_SUCCESS',
    FETCH_ALL_USERS_FAILED = 'FETCH_ALL_USERS_FAILED',
    SELECT_USER = 'SELECT_USER',
    SAVE_USER_INIT = 'SAVE_USER_INIT',
    SAVE_USER_SUCCESS = 'SAVE_USER_SUCCESS',
    SAVE_USER_FAILED = 'SAVE_USER_FAILED',
}

export enum BatchActionTypes {
    FETCH_ALL_BATCHES_INIT = 'FETCH_ALL_BATCHES_INIT',
    FETCH_ALL_BATCHES_SUCCESS = 'FETCH_ALL_BATCHES_SUCCESS',
    FETCH_ALL_BATCHES_FAILED = 'FETCH_ALL_BATCHES_FAILED',
    SELECT_BATCH = 'SELECT_BATCH',
    SAVE_BATCH_INIT = 'SAVE_BATCH_INIT',
    SAVE_BATCH_SUCCESS = 'SAVE_BATCH_SUCCESS',
    SAVE_BATCH_FAILED = 'SAVE_BATCH_FAILED',
    COMPLETE_BATCH_INIT = 'COMPLETE_BATCH_INIT',
    COMPLETE_BATCH_SUCCESS = 'COMPLETE_BATCH_SUCCESS',
    COMPLETE_BATCH_FAILED = 'COMPLETE_BATCH_FAILED',
}

export enum ProductActionTypes {
    FETCH_ALL_PRODUCTS_INIT = 'FETCH_ALL_PRODUCTS_INIT',
    FETCH_ALL_PRODUCTS_SUCCESS = 'FETCH_ALL_PRODUCTS_SUCCESS',
    FETCH_ALL_PRODUCTS_FAILED = 'FETCH_ALL_PRODUCTS_FAILED',
    SELECT_PRODUCT = 'SELECT_PRODUCT',

}
export enum RoomActionTypes {
    FETCH_ALL_ROOMS_INIT = 'FETCH_ALL_ROOMS_INIT',
    FETCH_ALL_ROOMS_SUCCESS = 'FETCH_ALL_ROOMS_SUCCESS',
    FETCH_ALL_ROOMS_FAILED = 'FETCH_ALL_ROOMS_FAILED',
    SELECT_ROOM = 'SELECT_ROOM',
    CHANGE_ROOM_STATUS_INIT = 'CHANGE_ROOM_STATUS_INIT',
    CHANGE_ROOM_STATUS_SUCCESS = 'CHANGE_ROOM_STATUS_SUCCESS',
    CHANGE_ROOM_STATUS_FAILED = 'CHANGE_ROOM_STATUS_FAILED',
    ASSIGN_BATCH_STATUS_INIT = 'ASSIGN_BATCH_STATUS_INIT',
    ASSIGN_BATCH_STATUS_SUCCESS = 'ASSIGN_BATCH_STATUS_SUCCESS',
    ASSIGN_BATCH_STATUS_FAILED = 'ASSIGN_BATCH_STATUS_FAILED',
    FETCH_ROOM_BY_DEVICE_IP_INIT = 'FETCH_ROOM_BY_DEVICE_IP_INIT',
    FETCH_ROOM_BY_DEVICE_IP_SUCCESS = 'FETCH_ROOM_BY_DEVICE_IP_SUCCESS',
    FETCH_ROOM_BY_DEVICE_IP_FAILED = 'FETCH_ROOM_BY_DEVICE_IP_FAILED',
}

export enum MasterActionTypes {
    FETCH_ALL_MASTER_INIT = 'FETCH_ALL_MASTERS_INIT',
    FETCH_ALL_MASTER_SUCCESS = 'FETCH_ALL_MASTERS_SUCCESS',
    FETCH_ALL_MASTER_FAILED = 'FETCH_ALL_MASTERS_FAILED',
    SELECT_MASTER = 'SELECT_MASTER',
    SAVE_MASTER_INIT = 'SAVE_MASTER_INIT',
    SAVE_MASTER_SUCCESS = 'SAVE_MASTER_SUCCESS',
    SAVE_MASTER_FAILED = 'SAVE_MASTER_FAILED',
    FETCH_ALL_PARENT_INIT = 'FETCH_ALL_PARENT_INIT',
    FETCH_ALL_PARENT_SUCCESS = 'FETCH_ALL_PARENT_SUCCESS',
    FETCH_ALL_PARENT_FAILED = 'FETCH_ALL_PARENT_FAILED',
    FETCH_ALL_MENU_INIT = 'FETCH_ALL_MENU_INIT',
    FETCH_ALL_MENU_SUCCESS = 'FETCH_ALL_MENU_SUCCESS',
    FETCH_ALL_MENU_FAILED = 'FETCH_ALL_MENU_FAILED',
    APPROVE_MASTER_INIT = 'APPROVE_MASTER_INIT',
    APPROVE_MASTER_SUCCESS = 'APPROVE_MASTER_SUCCESS',
    APPROVE_MASTER_FAILED = 'APPROVE_MASTER_FAILED',

}

export enum MenuActionTypes {
    FETCH_MENU_INIT = 'FETCH_MENU_INIT',
    FETCH_MENU_SUCCESS = 'FETCH_MENU_SUCCESS',
    FETCH_MENU_FAILED = 'FETCH_MENU_FAILED',
}

export enum RoleActionTypes {
    FETCH_ROLES_INIT = 'FETCH_ROLES_INIT',
    FETCH_ROLES_SUCCESS = 'FETCH_ROLES_SUCCESS',
    FETCH_ROLES_FAILED = 'FETCH_ROLES_FAILED',

    SELECT_ROLE = 'SELECT_ROLE',
    SAVE_ROLE_INIT = 'SAVE_ROLE_INIT',
    SAVE_ROLE_SUCCESS = 'SAVE_ROLE_SUCCESS',
    SAVE_ROLE_FAILED = 'SAVE_ROLE_FAILED',

    FETCH_PERMISSIONS_INIT = 'FETCH_PERMISSIONS_INIT',
    FETCH_PERMISSIONS_SUCCESS = 'FETCH_PERMISSIONS_SUCCESS',
    FETCH_PERMISSIONS_FAILED = 'FETCH_PERMISSIONS_FAILED',

}