import { combineReducers, Reducer } from 'redux';
import { createSelectorHook } from 'react-redux';
import themeReducer, { themeInitialState } from './theme/themeReducer';
import uiReducer, { uiInitialState } from './ui/ui.reducer';
import authenticationReducer, { authInitialState } from './authentication/authentication.reducer';
import { RootState } from './action-types';
import userReducer, { userInitialState } from './user/user.reducer';
import batchReducer, { batchInitialState } from './batch/batch.reducer';
import productReducer, { productInitialState } from './product/product.reducer';
import roomReducer, { roomInitialState } from './rooms/room.reducer';
import masterReducer, { masterInitialState } from './master/master.reducer';
import menuReducer, { menuInitialState } from './menu/menu.reducer';
import roleReducer, { roleInitialState } from './role/role.reducer';
import uomReducer,{ uomInitialState } from './uom/uom.reducer';

const reducer: Reducer<RootState> = combineReducers<RootState>({
  theme: themeReducer,
  authentication: authenticationReducer,
  UI: uiReducer,
  userState: userReducer,
  batchState: batchReducer,
  productState: productReducer,
  uomState: uomReducer,
  roomState: roomReducer,
  masterState: masterReducer,
  menuState: menuReducer,
  roleState: roleReducer
});
export const initialState: RootState = {
  theme: themeInitialState,
  authentication: authInitialState,
  UI: uiInitialState,
  userState: userInitialState,
  batchState: batchInitialState,
  productState: productInitialState,
  uomState: uomInitialState,
  roomState: roomInitialState,
  masterState: masterInitialState,
  menuState: menuInitialState,
  roleState: roleInitialState
};

export const useSelector = createSelectorHook();
export default reducer;


