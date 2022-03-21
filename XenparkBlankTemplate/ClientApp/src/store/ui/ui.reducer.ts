import { SET_ERRORS, LOADING_UI, CLEAR_ERRORS } from '../action-types'
export const uiInitialState = {
    loading: false,
    errors: null
}
const uiReducer = (state = uiInitialState, action: any) => {
    switch (action.type) {
        case SET_ERRORS:
            return {
                ...state,
                loading: false,
                errors: action.payload
            };
        case CLEAR_ERRORS:
            return {
                ...state,
                loading: false,
                errors: null
            };
        case LOADING_UI:
            return {
                ...state,
                loading: true
            }
        default:
            return state;
    }
}

export default uiReducer;