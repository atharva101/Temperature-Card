import * as React from 'react';
import { useState } from 'react';
import { useDispatch } from 'react-redux';
import PerfectScrollbar from 'react-perfect-scrollbar';
import NavGroup from './NavGroup';
import * as actionTypes from '../../../../store/theme/themeActions';
import { useSelector } from '../../../../store/reducer';
import { IMenuItem } from '../../../../models/menu';

interface INavContent {
    navigation: IMenuItem[]
}
const NavContent = (props: INavContent) => {
    const dispatch = useDispatch();
    const layout = useSelector((state) => state.theme.layout);
    const rtlLayout = useSelector((state) => state.theme.rtlLayout);
    const onNavContentLeave = () => dispatch({ type: actionTypes.NAV_CONTENT_LEAVE });
    const [data, setData] = useState({
        scrollWidth: 0,
        prevDisable: true,
        nextDisable: false
    });
    const scrollPrevHandler = () => {
        const sidenavWrapper = document.getElementById('sidenav-wrapper');
        if (sidenavWrapper) {
            const wrapperWidth = sidenavWrapper.clientWidth;
            let scrollWidth = data.scrollWidth - wrapperWidth;
            if (scrollWidth < 0) {
                setData({ ...data, scrollWidth: 0, prevDisable: true, nextDisable: false });
            }
            else {
                setData({ ...data, scrollWidth: scrollWidth, prevDisable: false });
            }
        }
    };
    const scrollNextHandler = () => {
        const sidenavWrapper = document.getElementById('sidenav-wrapper');
        const sidenavHorizontal = document.getElementById('sidenav-horizontal');
        if (sidenavWrapper && sidenavHorizontal) {
            const wrapperWidth = sidenavWrapper.clientWidth;
            const contentWidth = sidenavHorizontal.clientWidth;
            let scrollWidth = data.scrollWidth + (wrapperWidth - 80);
            if (scrollWidth > contentWidth - wrapperWidth) {
                scrollWidth = contentWidth - wrapperWidth + 80;
                setData({ ...data, scrollWidth: scrollWidth, prevDisable: false, nextDisable: true });
            }
            else {
                setData({ ...data, scrollWidth: scrollWidth, prevDisable: false });
            }
        }
    };
    
    const navItems = props.navigation && props.navigation.map((item: IMenuItem) => {
        switch (item.Type) {
            case 'group':
                return <NavGroup key={item.Id} group={item} />;
            default:
                return false;
        }
    });
    let scrollStyle = {
        marginLeft: '-' + data.scrollWidth + 'px'
    };
    if (layout === 'horizontal' && rtlLayout) {
        // scrollStyle = {
        //     marginRight: '-' + data.scrollWidth + 'px'
        // };
    }
    let mainContent;
    if (layout === 'horizontal') {
        let prevClass = ['sidenav-horizontal-prev'];
        if (data.prevDisable) {
            prevClass = [...prevClass, 'disabled'];
        }
        let nextClass = ['sidenav-horizontal-next'];
        if (data.nextDisable) {
            nextClass = [...nextClass, 'disabled'];
        }
        mainContent = (<div className="navbar-content sidenav-horizontal" id="layout-sidenav">
            <a href='#/' className={prevClass.join(' ')} onClick={scrollPrevHandler}>
                <span />
            </a>
            <div id="sidenav-wrapper" className="sidenav-horizontal-wrapper">
                <ul id="sidenav-horizontal" className="nav pcoded-inner-navbar sidenav-inner" onMouseLeave={onNavContentLeave} style={scrollStyle}>
                    {navItems}
                </ul>
            </div>
            <a href='#/' className={nextClass.join(' ')} onClick={scrollNextHandler}>
                <span />
            </a>
        </div>);
    }
    else {
        mainContent = (<div className="navbar-content next-scroll" style={{overflow:'auto'}}>
            <PerfectScrollbar options={{ wheelSpeed: 2, swipeEasing: true }}>
                <ul className="nav pcoded-inner-navbar" id="nav-ps-next">
                    {navItems}

                </ul>
            </PerfectScrollbar>
        </div>);
    }
    return <>{mainContent}</>;
};
export default NavContent;
