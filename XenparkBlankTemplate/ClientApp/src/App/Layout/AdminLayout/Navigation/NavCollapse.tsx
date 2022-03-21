import * as React from 'react';
import { useEffect } from 'react';
import { useDispatch } from 'react-redux';
import * as actionTypes from '../../../../store/theme/themeActions';
import { useSelector } from '../../../../store/reducer';
import NavIcon from './NavIcon';
import NavBadge from './NavBadge';
import NavItem from './NavItem';
import LoopNavCollapse from '../Navigation/NavCollapse';
import { IMenuItem } from '../../../../models/menu';
interface INavCollapse {
    collapse: IMenuItem;
    type: string;
}
const NavCollapse = (props: INavCollapse) => {
    const dispatch = useDispatch();
    const layout = useSelector((state) => state.theme.layout);
    const isOpen = useSelector((state) => state.theme.isOpen);
    const isTrigger = useSelector((state) => state.theme.isTrigger);
    const onCollapseToggle = (id: string, type: string) => dispatch({ type: actionTypes.COLLAPSE_TOGGLE, menu: { id: id, type: type } });
    const onNavCollapseLeave = (id: string, type: string) => dispatch({ type: actionTypes.NAV_COLLAPSE_LEAVE, menu: { id: id, type: type } });
    useEffect(() => {
        const currentIndex = document.location.pathname
            .toString()
            .split('/')
            .findIndex((id) => id === props.collapse.Id);
        if (currentIndex > -1) {
            onCollapseToggle(props.collapse.Id, props.type);
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);
    let navItems: any = '';
    if (props.collapse.Children) {
        const collapses = props.collapse.Children;
        navItems = Object.keys(collapses).map((key) => {
            const item = collapses[parseInt(key)];
            switch (item.Type) {
                case 'collapse':
                    return <LoopNavCollapse key={item.Id} collapse={item} type="sub" />;
                case 'item':
                    return <NavItem key={item.Id} item={item} />;
                default:
                    return false;
            }
        });
    }
    let itemTitle: any = null;
    if (props.collapse.Icon) {
        itemTitle = <span className="pcoded-mtext">{props.collapse.Title}</span>;
    }
    let navLinkClass = ['nav-link'];
    let navItemClass = ['nav-item', 'pcoded-hasmenu'];
    const openIndex = isOpen.findIndex((id: any) => id === props.collapse.Id);
    if (openIndex > -1) {
        navItemClass = [...navItemClass, 'active'];
        if (layout !== 'horizontal') {
            navLinkClass = [...navLinkClass, 'active'];
        }
    }
    const triggerIndex = isTrigger.findIndex((id: any) => id === props.collapse.Id);
    if (triggerIndex > -1) {
        navItemClass = [...navItemClass, 'pcoded-trigger'];
    }
    const currentIndex = document.location.pathname
        .toString()
        .split('/')
        .findIndex((id) => id === props.collapse.Id);
    if (currentIndex > -1) {
        navItemClass = [...navItemClass, 'active'];
        if (layout !== 'horizontal') {
            navLinkClass = [...navLinkClass, 'active'];
        }
    }
    const subContent = (<>
        <a href='#/' className={navLinkClass.join(' ')} onClick={() => onCollapseToggle(props.collapse.Id, props.type)}>
            <NavIcon items={props.collapse} />
            {itemTitle}
            <NavBadge layout={layout} items={props.collapse} />
        </a>
        <ul className="pcoded-submenu">{navItems}</ul>
    </>);
    let mainContent: any = '';
    if (layout === 'horizontal') {
        mainContent = (<li className={navItemClass.join(' ')} onMouseLeave={() => onNavCollapseLeave(props.collapse.Id, props.type)} onMouseEnter={() => onCollapseToggle(props.collapse.Id, props.type)}>
            {subContent}
        </li>);
    }
    else {
        mainContent = <li className={navItemClass.join(' ')}>{subContent}</li>;
    }
    return <>{mainContent}</>;
};
export default NavCollapse;
