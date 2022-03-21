import { IProduct } from "../../models/product";
import { ProductActionTypes } from "../action-types";
import { ProductAction, ProductState } from "./product.action";


export const productInitialState: ProductState = {
    products: [], loading: false, error: '', selectedProductId: -1
};

const productReducer = (
    state: ProductState = productInitialState,
    action: ProductAction
): ProductState => {
    switch (action.type) {
        case ProductActionTypes.FETCH_ALL_PRODUCTS_INIT:
            return {
                ...state,
                loading: true,
                error: ''
            }
        case ProductActionTypes.FETCH_ALL_PRODUCTS_SUCCESS:
            return {
                ...state,
                loading: false,
                products: action.payload as IProduct[],
            }
        case ProductActionTypes.FETCH_ALL_PRODUCTS_FAILED:
            return {
                ...state,
                loading: false,
                error: action.payload as string
            }
        case ProductActionTypes.SELECT_PRODUCT:
            return {
                ...state,
                selectedProductId: action.payload as number
            }
    }
    return state;
}

export default productReducer