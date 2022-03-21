import * as React from 'react';
import { useEffect, Suspense } from 'react';
import { Switch, Redirect } from 'react-router-dom';
import { connect, useDispatch } from 'react-redux';
import Navigation from '../AdminLayout/Navigation/Navigation';
import NavBar from './NavBar/NavBar';
import Breadcrumb from './Breadcrumb';
import Loader from '../Loader';
import routes from '../../Routes/routes';
import useWindowSize from '../../../hooks/useWindowSize';
import * as actionTypes from '../../../store/theme/themeActions';
import { useSelector } from '../../../store/reducer';
import PrivateRoute from '../../../helpers/PrivateRoute';
import { getUserPermissions, logoutUser } from '../../../store/authentication/authentication.actions';
import { RootState } from '../../../store/action-types';
import { IPermission } from '../../../models/role';
interface IAdminLayoutProps {
    permissions: IPermission[];
}
const AdminLayout = (props: IAdminLayoutProps) => {
    const { windowWidth } = useWindowSize();
    const dispatch = useDispatch();
    const defaultPath = useSelector((state) => state.theme.defaultPath);
    const collapseMenu = useSelector((state) => state.theme.collapseMenu);
    const layout = useSelector((state) => state.theme.layout);
    const subLayout = useSelector((state) => state.theme.subLayout);

    useEffect(() => {
        if (windowWidth > 992 && windowWidth <= 1024 && layout !== 'horizontal') {
            dispatch({ type: actionTypes.COLLAPSE_MENU });
        }

        const authToken = localStorage.access_token;
        if (!authToken) {
            dispatch(logoutUser());
        }
        else {
            if (!props.permissions || props.permissions.length === 0)
                dispatch(getUserPermissions());
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);
    const mobileOutClickHandler = () => {
        if (windowWidth < 992 && collapseMenu) {
            dispatch({ type: actionTypes.COLLAPSE_MENU });
        }
    };
    let mainClass = ['pcoded-wrapper'];
    if (layout === 'horizontal' && subLayout === 'horizontal-2') {
        mainClass = [...mainClass, 'container'];
    }
    return (<>
        <Navigation />
        <NavBar />
        <div className="pcoded-main-container" onClick={() => mobileOutClickHandler}>
            <div className={mainClass.join(' ')}>
                <div className="pcoded-content">
                    <div className="pcoded-inner-content">
                        <Breadcrumb />
                        <div className="main-body">
                            <div className="page-wrapper">
                                <Suspense fallback={<Loader />}>
                                    <Switch>
                                        {routes.map((route, index) => {
                                            return route.component ? (<PrivateRoute key={index} path={route.path} exact={route.exact} component={route.component} />) : null;
                                        })}
                                        <Redirect from="/" to={defaultPath} />
                                    </Switch>
                                </Suspense>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </>);
};

const mapStateToProps = (state: RootState) => ({
    permissions: state.authentication.permissions as IPermission[]
});
export default connect(mapStateToProps)(AdminLayout);
