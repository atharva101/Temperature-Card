import * as React from 'react';
import { IMenuItem } from '../../../../models/menu';
import NavCollapse from './NavCollapse';
import NavItem from './NavItem';
interface INavGroup {
    group: IMenuItem
}

const navGroup = (props: INavGroup) => {
    let navItems: any = '';

    if (props.group.Children) {
        const groups = props.group.Children;
        navItems = Object.keys(groups).map((key) => {
            const item = groups[parseInt(key)] as IMenuItem;
            switch (item.Type) {
                case 'collapse':
                    return <NavCollapse key={item.Id} collapse={item} type="main" />;
                case 'item':
                    return <NavItem key={item.Id} item={item} />;
                default:
                    return false;
            }
        });
    }
    return (<>
        <li key={props.group.Id} className="nav-item pcoded-menu-caption">
            {/* <label>{props.group.Title}</label> */}
            {props.group.Title}
        </li>
        {navItems}
    </>);
};
export default navGroup;
