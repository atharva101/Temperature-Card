import * as React from 'react';
const Dashboard = React.lazy(() => import('../Pages/Dashboard'));
const RoomList = React.lazy(() => import('../Pages/RoomList/RoomList'));
const RoomDashboard = React.lazy(() => import('../Pages/RoomList/RoomDashboard'));

const User = React.lazy(() => import('../Pages/User/User'));
const MaintainUser = React.lazy(() => import('../Pages/User/MaintainUser'));

const Batch = React.lazy(() => import('../Pages/Batch/Batch'));
const MaintainBatch = React.lazy(() => import('../Pages/Batch/MaintainBatch'));

const Master = React.lazy(() => import('../Pages/Master/Master'));
const MaintainMaster = React.lazy(() => import('../Pages/Master/MaintainMaster'));

const Role = React.lazy(() => import('../Pages/Master/Role/Role'));
const MaintainRole = React.lazy(() => import('../Pages/Master/Role/MaintainRole'));


const routes = [
    { path: '/dashboard', exact: true, name: 'Dashboard', component: Dashboard },
    { path: '/room-list', exact: true, name: 'Rooms', component: RoomList },
    { path: '/room-dashboard', exact: true, name: 'Room Dashboard', component: RoomDashboard },
    { path: '/user', exact: true, name: 'User', component: User },
    { path: '/maintain-user', exact: true, name: 'Add Rdit User', component: MaintainUser },

    { path: '/batch', exact: true, name: 'Batch', component: Batch },
    { path: '/maintain-batch', exact: true, name: 'Add Edit User', component: MaintainBatch },

    { path: '/plant-master', exact: true, name: 'Plant', component: Master },
    { path: '/maintain-plant', exact: true, name: 'Add Edit Plant', component: MaintainMaster },

    { path: '/block-master', exact: true, name: 'Analytics', component: Master },
    { path: '/maintain-block', exact: true, name: 'Add Edit block', component: MaintainMaster },

    { path: '/area-master', exact: true, name: 'Analytics', component: Master },
    { path: '/maintain-area', exact: true, name: 'Add Edit area', component: MaintainMaster },
    
    { path: '/room-master', exact: true, name: 'Analytics', component: Master },
    { path: '/maintain-room', exact: true, name: 'Add Edit room', component: MaintainMaster },

    { path: '/product-master', exact: true, name: 'Analytics', component: Master },
    { path: '/maintain-product', exact: true, name: 'Add Edit room', component: MaintainMaster },

    { path: '/role', exact: true, name: 'Analytics', component: Role },
    { path: '/maintain-role', exact: true, name: 'Add Edit room', component: MaintainRole },

];
export default routes;
