import * as React from 'react';

const Error = React.lazy(() => import('../Pages/Error'));
const Login = React.lazy(() => import('../Pages/Login'));
const route = [
    { path: '/login', exact: true, name: 'Login', component: Login },
    { path: '/error', exact: true, name: 'Error', component: Error },
    
];
export default route;
