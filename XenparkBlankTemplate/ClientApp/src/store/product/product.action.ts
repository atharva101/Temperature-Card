
import { IProduct } from "../../models/product";
import { ProductActionTypes } from "../action-types";
import axios, { AxiosResponse } from "axios";
import Config from "../../config";

export type ProductState = {
    products: IProduct[];
    selectedProductId: number;
    loading: boolean;
    error: string;
}

export type ProductAction = {
    type: string;
    payload: IProduct[] | boolean | string | number;
}

type DispatchProduct = (args: ProductAction) => ProductAction

export const fetchAllProducts = (approveOnly: boolean = false) => (dispatch: DispatchProduct) => {
    dispatch({ type: ProductActionTypes.FETCH_ALL_PRODUCTS_INIT, payload: true });
    let queryString = '';
    queryString += '?type=product' +
        '&approveOnly=' + approveOnly;
    axios.get(Config.apiUrl + 'api/Master/GetMasters' + queryString)
        .then((res: AxiosResponse<IProduct[]>) => {
            dispatch({
                type: ProductActionTypes.FETCH_ALL_PRODUCTS_SUCCESS,
                payload: res.data,
            });
        }).catch(err => {
            dispatch({ type: ProductActionTypes.FETCH_ALL_PRODUCTS_FAILED, payload: err });
        });
}
export const selectProduct = (id: number) => (dispatch: DispatchProduct) => {
    dispatch({ type: ProductActionTypes.SELECT_PRODUCT, payload: id });
}