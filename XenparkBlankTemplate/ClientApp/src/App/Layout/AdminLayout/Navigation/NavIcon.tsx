import * as React from 'react';
import { IMenuItem } from '../../../../models/menu';

interface INavNavIcon {
    items: IMenuItem
}

const NavIcon = (props : INavNavIcon) => {
    return props.items.Icon ? (<span className="pcoded-micon">
            <i className={props.items.Icon}/>
        </span>) : null;
};
export default NavIcon;
