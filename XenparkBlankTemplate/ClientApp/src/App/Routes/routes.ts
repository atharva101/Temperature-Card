import * as React from 'react';
import AreaMaster from '../Pages/Master/AreaMaster/AreaMaster';
import MaintainAreaMaster from '../Pages/Master/AreaMaster/MaintainAreaMaster';
import BlockMaster from '../Pages/Master/BlockMaster/BlockMaster';
import MaintainBlockMaster from '../Pages/Master/BlockMaster/MaintainBlockMaster';
import MaintainPlantMaster from '../Pages/Master/PlantMaster/MaintainPlantMaster';
import PlantMaster from '../Pages/Master/PlantMaster/PlantMaster';
import MaintainProductMaster from '../Pages/Master/ProductMaster/MaintainProductMaster';
import ProductMaster from '../Pages/Master/ProductMaster/ProductMaster';
import MaintainRoomMaster from '../Pages/Master/RoomMaster/MaintainRoomMaster';
import RoomMaster from '../Pages/Master/RoomMaster/RoomMaster';
import MaintainUOMMaster from '../Pages/Master/UOMMaster/MaintainUOMMaster';
import UOMMaster from '../Pages/Master/UOMMaster/UOMMaster';
const Dashboard = React.lazy(() => import('../Pages/Dashboard'));
const RoomList = React.lazy(() => import('../Pages/RoomList/RoomList'));
const RoomDashboard = React.lazy(() => import('../Pages/RoomList/RoomDashboard'));

const User = React.lazy(() => import('../Pages/User/User'));
const MaintainUser = React.lazy(() => import('../Pages/User/MaintainUser'));

const Batch = React.lazy(() => import('../Pages/Batch/Batch'));
const MaintainBatch = React.lazy(() => import('../Pages/Batch/MaintainBatch'));

const Master = React.lazy(() => import('../Pages/Master/Master'));
const MaintainMaster = React.lazy(() => import('../Pages/Master/MaintainMaster'));

const Role = React.lazy(() => import('../Pages/Master/RoleMaster/Role'));
const MaintainRole = React.lazy(() => import('../Pages/Master/RoleMaster/MaintainRole'));


const routes = [
    { path: '/dashboard', exact: true, name: 'Dashboard', component: Dashboard },
    { path: '/room-list', exact: true, name: 'Rooms', component: RoomList },
    { path: '/room-dashboard', exact: true, name: 'Room Dashboard', component: RoomDashboard },
    { path: '/user', exact: true, name: 'User', component: User },
    { path: '/maintain-user', exact: true, name: 'Add Rdit User', component: MaintainUser },

    { path: '/batch', exact: true, name: 'Batch', component: Batch },
    { path: '/maintain-batch', exact: true, name: 'Add Edit User', component: MaintainBatch },

    { path: '/plant-master', exact: true, name: 'Plant', component: PlantMaster },
    { path: '/maintain-plant', exact: true, name: 'Add Edit Plant', component: MaintainPlantMaster },

    { path: '/block-master', exact: true, name: 'Block', component: BlockMaster },
    { path: '/maintain-block', exact: true, name: 'Add Edit block', component: MaintainBlockMaster },

    { path: '/area-master', exact: true, name: 'Area', component: AreaMaster },
    { path: '/maintain-area', exact: true, name: 'Add Edit area', component: MaintainAreaMaster },
    
    { path: '/room-master', exact: true, name: 'Analytics', component: RoomMaster },
    { path: '/maintain-room', exact: true, name: 'Add Edit room', component: MaintainRoomMaster },

    { path: '/product-master', exact: true, name: 'Analytics', component: ProductMaster },
    { path: '/maintain-product', exact: true, name: 'Add Edit room', component: MaintainProductMaster },

    { path: '/uom-master', exact: true, name: 'Analytics', component: UOMMaster },
    { path: '/maintain-uom', exact: true, name: 'Add Edit Unit Of Measure', component: MaintainUOMMaster },

    { path: '/role', exact: true, name: 'Analytics', component: Role },
    { path: '/maintain-role', exact: true, name: 'Add Edit room', component: MaintainRole },

];
export default routes;
