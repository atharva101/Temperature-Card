import reducer, { initialState } from './reducer';
import { createStore, applyMiddleware, compose } from 'redux';
import thunk from 'redux-thunk'
import { RootState } from './action-types';


const middleware = [thunk];
//this is for redux devtool purpose
declare global {
    interface Window {
        __REDUX_DEVTOOLS_EXTENSION__?: typeof compose;
    }
}

const store = createStore<RootState, any, any, any>(
    reducer,
    initialState,
    //compose(applyMiddleware(...middleware))
    compose(applyMiddleware(...middleware), (window.__REDUX_DEVTOOLS_EXTENSION__
        ? window.__REDUX_DEVTOOLS_EXTENSION__()
        : (f:any) => f) as any)
);

export default store; //= createStore(reducer, initialState);