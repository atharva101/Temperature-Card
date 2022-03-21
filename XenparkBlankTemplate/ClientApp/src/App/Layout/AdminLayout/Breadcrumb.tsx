import * as React from 'react';
import { useEffect, useState, useCallback } from 'react';
import { useSelector } from '../../../store/reducer';
import { Link } from 'react-router-dom';
import config from '../../../config';
import { IMenuItem } from '../../../models/menu';
import { RootState } from '../../../store/action-types';

let initialMenuState: IMenuItem = { Id: '', Title: '', Type: '' };
const Breadcrumb = (props: any) => {
    const [main, setMain] = useState(initialMenuState);
    const [item, setItem] = useState(initialMenuState);
    const getCollapse = useCallback((item: IMenuItem) => {
        if (item.Children) {
            item.Children.filter((collapse: any) => {
                if (collapse.Type && collapse.Type === 'collapse') {
                    getCollapse(collapse);
                }
                else if (collapse.Type && collapse.Type === 'item') {
                    if (document.location.pathname === config.basename + collapse.url) {
                        setItem(collapse);
                        setMain(item);
                    }
                }
                return false;
            });
        }
    }, []);

    const navigation: IMenuItem[] = useSelector((state:RootState) => state.menuState.menu);
    useEffect(() => {
        navigation.map((item, index) => {
            if (item.Type && item.Type === 'group') {
                getCollapse(item);
            }
            return false;
        });
    }, [props, getCollapse]);
    let main_, item_;
    let breadcrumb: any;
    let title = 'Welcome';
    if (main && main.Type === 'collapse') {
        main_ = (<li className="breadcrumb-item">
            <a href='#/'>{main.Title}</a>
        </li>);
    }
    if (item && item.Type === 'item') {
        title = item.Title;
        item_ = (<li className="breadcrumb-item">
            <a href='#/'>{title}</a>
        </li>);
        if (item.Breadcrumbs !== false) {
            breadcrumb = (<div className="page-header">
                <div className="page-block">
                    <div className="row align-items-center">
                        <div className="col-md-12">
                            <div className="page-header-title">
                                <h5 className="m-b-10">{title}</h5>
                            </div>
                            <ul className="breadcrumb">
                                <li className="breadcrumb-item">
                                    <Link to="/">
                                        <i className="feather icon-home" />
                                    </Link>
                                </li>
                                {main_}
                                {item_}
                            </ul>
                        </div>
                    </div>
                </div>
            </div>);
        }
    }
    document.title = title + ' | Real time room Visibility | XenPark Solutions';
    return <>{breadcrumb}</>;
};
export default Breadcrumb;
