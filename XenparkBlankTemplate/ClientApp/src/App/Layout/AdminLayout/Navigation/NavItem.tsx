import * as React from 'react';
import { useDispatch } from 'react-redux';
import { NavLink } from 'react-router-dom';
import useWindowSize from '../../../../hooks/useWindowSize';
import NavIcon from './NavIcon';
import NavBadge from './NavBadge';
import * as actionTypes from '../../../../store/theme/themeActions';
import { useSelector } from '../../../../store/reducer';
import { IMenuItem } from '../../../../models/menu';

interface INavItem {
    item: IMenuItem;
}
const NavItem = (props: INavItem) => {
    const { windowWidth } = useWindowSize();
    const dispatch = useDispatch();
    const layout = useSelector((state: any) => state.theme.layout);
    const onItemClick = () => dispatch({ type: actionTypes.COLLAPSE_MENU });
    const onItemLeave = () => dispatch({ type: actionTypes.NAV_CONTENT_LEAVE });
    let itemTitle: any;
    if (props.item.Icon) {
        itemTitle = <span className="pcoded-mtext">{props.item.Title}</span>;
    }
    let itemTarget = '';
    if (props.item.Target) {
        itemTarget = '_blank';
    }
    let subContent;
    if (props.item.External) {
        subContent = (<a href={props.item.URL} target="_blank" rel="noopener noreferrer">
            <NavIcon items={props.item} />
            {itemTitle ? itemTitle : props.item.Title}
            <NavBadge layout={layout} items={props.item} />
        </a>);
    }
    else {
        subContent = (<NavLink to={props.item.URL} className="nav-link" exact={true} target={itemTarget}>
            <NavIcon items={props.item} />
            {itemTitle ? itemTitle : props.item.Title}
            <NavBadge layout={layout} items={props.item} />
        </NavLink>);
    }
    let mainContent;
    if (layout === 'horizontal') {
        mainContent = <li onClick={onItemLeave}>{subContent}</li>;
    }
    else {
        if (windowWidth < 992) {
            mainContent = (<li className={props.item.Classes} onClick={onItemClick}>
                {subContent}
            </li>);
        }
        else {
            mainContent = <li className={props.item.Classes}>{subContent}</li>;
        }
    }
    return <>{mainContent}</>;
};
export default NavItem;
