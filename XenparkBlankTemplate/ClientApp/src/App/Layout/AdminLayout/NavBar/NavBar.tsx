import * as React from 'react';
import { useState } from 'react';
import { useDispatch } from 'react-redux';
import useWindowSize from '../../../../hooks/useWindowSize';
import NavLeft from './NavLeft';
import NavRight from './NavRight';
import * as actionTypes from '../../../../store/theme/themeActions';
//import logo from '../../../../assets/images/logo xenpark only black transparent.png';
import logo from '../../../../assets/images/MylanHeaderlogo.png';
import { useSelector } from '../../../../store/reducer';
const NavBar = () => {
    const dispatch = useDispatch();
    const { windowWidth } = useWindowSize();
    const rtlLayout = useSelector((state) => state.theme.rtlLayout);
    const headerBackColor = useSelector((state) => state.theme.headerBackColor);
    const headerFixedLayout = useSelector((state) => state.theme.headerFixedLayout);
    const collapseMenu = useSelector((state) => state.theme.collapseMenu);
    const layout = useSelector((state) => state.theme.layout);
    const subLayout = useSelector((state) => state.theme.subLayout);
    const onToggleNavigation = () => dispatch({ type: actionTypes.COLLAPSE_MENU });
    const [rightToggle, setRightToggle] = useState(false);
    let headerClass = ['navbar', 'pcoded-header', 'navbar-expand-lg', 'header-blue'];
    document.body.classList.remove('background-blue');
    document.body.classList.remove('background-red');
    document.body.classList.remove('background-purple');
    document.body.classList.remove('background-info');
    document.body.classList.remove('background-green');
    document.body.classList.remove('background-dark');
    document.body.classList.remove('background-grd-blue');
    document.body.classList.remove('background-grd-red');
    document.body.classList.remove('background-grd-purple');
    document.body.classList.remove('background-grd-info');
    document.body.classList.remove('background-grd-green');
    document.body.classList.remove('background-grd-dark');
    document.body.classList.remove('background-img-1');
    document.body.classList.remove('background-img-2');
    document.body.classList.remove('background-img-3');
    document.body.classList.remove('background-img-4');
    document.body.classList.remove('background-img-5');
    document.body.classList.remove('background-img-6');
    document.body.classList.add(headerBackColor);
    if (headerFixedLayout) {
        headerClass = [...headerClass, 'headerpos-fixed'];
    }
    let toggleClass = ['mobile-menu'];
    if (collapseMenu) {
        toggleClass = [...toggleClass, 'on'];
    }
    let mainLogo = logo;
    let navHtml;
    if (!rightToggle && windowWidth < 992) {
        navHtml = '';
    }
    else {
        navHtml = (<div className="collapse navbar-collapse d-flex">
                <NavLeft />
                <NavRight rtlLayout={rtlLayout}/>
            </div>);
    }
    let navBar = (<>
            <div className="m-header">
                <a className={toggleClass.join(' ')} id="mobile-collapse1" href='#/' onClick={onToggleNavigation}>
                    <span />
                </a>
                <a href='#/' className="b-brand">
                    <img id="main-logo" src={mainLogo} alt="" className="logo" style={{width: "160px"}}/>
                </a>
                <a className="mob-toggler" href='#/' onClick={() => setRightToggle(!rightToggle)}>
                    <i className="feather icon-more-vertical"/>
                </a>
            </div>
            {navHtml}
        </>);
    if (layout === 'horizontal' && subLayout === 'horizontal-2') {
        navBar = <div className="container">{navBar}</div>;
    }
    return <header className={headerClass.join(' ')}>{navBar}</header>;
};
export default NavBar;
