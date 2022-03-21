import * as React from 'react';
import { useEffect } from 'react';
import { connect, useDispatch } from 'react-redux';
import useWindowSize from '../../../../hooks/useWindowSize';
import NavContent from './NavContent';
import OutsideClick from './OutsideClick';
import * as actionTypes from '../../../../store/theme/themeActions';
import { useSelector } from '../../../../store/reducer';
//import navigation from '../../../Routes/menu-items';
import { fetchMenus } from '../../../../store/menu/menu.action';
import { RootState } from '../../../../store/action-types';
import { IMenuItem } from '../../../../models/menu';
const Navigation = (props: any) => {
    const { windowWidth } = useWindowSize();
    const dispatch = useDispatch();
    const layout = useSelector((state) => state.theme.layout);
    const subLayout = useSelector((state) => state.theme.subLayout);
    const collapseMenu = useSelector((state) => state.theme.collapseMenu);
    const layoutType = useSelector((state) => state.theme.layoutType);
    const rtlLayout = useSelector((state) => state.theme.rtlLayout);
    const navFixedLayout = useSelector((state) => state.theme.navFixedLayout);
    const headerFixedLayout = useSelector((state) => state.theme.headerFixedLayout);
    const boxLayout = useSelector((state) => state.theme.boxLayout);
    const onChangeLayout = (layout: any) => dispatch({ type: actionTypes.CHANGE_LAYOUT, layout: layout });
    const resize = () => {
        const rootDom = document.getElementById('root');
        if (rootDom) {
            const contentWidth = rootDom.clientWidth;
            if (layout === 'horizontal' && contentWidth < 992) {
                onChangeLayout('vertical');
            }
        }
    };

    //const navigation: IMenuItem[] = useSelector((state: RootState) => state.menuState.menu);
    const [navigation, setNavigation] = React.useState(props.menu as IMenuItem[]);
    useEffect(() => {
        if (!props.menu || props.menu.length < 1)
            dispatch(fetchMenus());
    }, []);

    useEffect(() => {
        setNavigation(props.menu as IMenuItem[]);

    }, [props.menu]);

    useEffect(() => {
        resize();
        window.addEventListener('resize', resize);
        return () => {
            window.removeEventListener('resize', resize);
        };
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);
    const scroll = () => {
        if (navFixedLayout && !headerFixedLayout) {
            const el = document.querySelector<HTMLElement>('.pcoded-navbar.menupos-fixed');
            if (!el)
                return;
            const scrollPosition = window.pageYOffset;
            if (scrollPosition > 60) {
                el.style.position = 'fixed';
                el.style.transition = 'none';
                el.style.marginTop = '0';
            }
            else {
                el.style.position = 'absolute';
                el.style.marginTop = '50px';
            }
        }
        else {
            const navBarDom = document.querySelector('.pcoded-navbar');
            if (navBarDom)
                navBarDom.removeAttribute('style');
        }
    };
    let navClass = ['pcoded-navbar'];
    navClass = [...navClass, layoutType];
    if (layout === 'horizontal') {
        navClass = [...navClass, 'theme-horizontal'];
    }
    else {
        if (navFixedLayout) {
            navClass = [...navClass, 'menupos-fixed'];
        }
        if (navFixedLayout && !headerFixedLayout) {
            window.addEventListener('scroll', scroll, true);
            /*window.scrollTo(0, 0);*/
        }
        else {
            window.removeEventListener('scroll', scroll, false);
        }
    }
    if (windowWidth < 992 && collapseMenu) {
        navClass = [...navClass, 'mob-open'];
    }
    else if (collapseMenu) {
        navClass = [...navClass, 'navbar-collapsed'];
    }
    if (layoutType === 'dark') {
        document.body.classList.add('able-pro-dark');
    }
    else {
        document.body.classList.remove('able-pro-dark');
    }
    if (rtlLayout) {
        document.body.classList.add('able-pro-rtl');
    }
    else {
        document.body.classList.remove('able-pro-rtl');
    }
    if (boxLayout) {
        document.body.classList.add('container');
        document.body.classList.add('box-layout');
    }
    else {
        document.body.classList.remove('container');
        document.body.classList.remove('box-layout');
    }
    let navBarClass = ['navbar-wrapper'];
    if (layout === 'horizontal' && subLayout === 'horizontal-2') {
        navBarClass = [...navBarClass, 'container'];
    }
    return (
        <nav className={navClass.join(' ')}>
            {
                windowWidth < 992
                    ?
                    (<OutsideClick>
                        <div className="navbar-wrapper">
                            <NavContent navigation={navigation} />
                        </div>
                    </OutsideClick>
                    )
                    :
                    (navigation && <div className={navBarClass.join(' ')}>
                        <NavContent navigation={navigation} />
                    </div>
                    )
            }
        </nav>
    );
};

const mapStateToProps = (state: RootState) => ({
    menu: state.menuState.menu as IMenuItem[],
});
export default connect(mapStateToProps)(Navigation);
