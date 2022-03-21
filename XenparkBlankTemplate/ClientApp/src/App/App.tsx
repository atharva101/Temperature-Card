
import { Switch, Redirect, Route, useLocation } from 'react-router-dom';
import Config from '../config';
import ScrollToTop from './Layout/ScrollToTop';
import { lazy, Suspense, useEffect } from 'react';
import routes from './Routes/routes';
import routesOnePage from './Routes/route';
import Loader from './Layout/Loader';
import { CheckAuthentication } from '../helpers/CheckAuthentication';
import GuestRoute from '../helpers/GuestRoute';
const AdminLayout = lazy(() => import('../App/Layout/AdminLayout/AdminLayout'));
const App = () => {
  const location = useLocation();

  useEffect(() => {
    CheckAuthentication();
  }, []);

  return (<>
    <ScrollToTop>
      <Suspense fallback={<Loader />}>
        {/* <Route path={routesOnePage.map((x) => x.path)}>
          <Switch location={location} key={location.pathname}>
            {routesOnePage.map((route, index) => {
              return route.component ? (<GuestRoute key={index} path={route.path} exact={route.exact} component={route.component} />) : null;
            })}
          </Switch>
        </Route> */}
        <Switch location={location} key={location.pathname}>
          {routesOnePage.map((route, index) => {
            return route.component ? (<GuestRoute key={index} path={route.path} exact={route.exact} component={route.component} />) : null;
          })}
          {routes.map((x, index) =>
            <Route path={x.path} key={index}>
              <AdminLayout />
            </Route>
          )}
        </Switch>



        {/* <Route path={routes.map((x) => x.path)}>
          <AdminLayout />
        </Route> */}
        <Route path={'/'} exact>
          <Redirect to={Config.defaultPath} />
        </Route>
      </Suspense>
    </ScrollToTop>
    <div className="backdrop" />
  </>);
};
export default App;