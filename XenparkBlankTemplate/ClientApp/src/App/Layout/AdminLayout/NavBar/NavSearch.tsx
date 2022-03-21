import * as React from 'react';
import { useState } from 'react';
const NavSearch = () => {
    const [isSearch, setIsSearch] = useState(false);
    const searchStyle = isSearch ? 'block' : 'none';
    return (<>
            <a href='#/' className="pop-search" onClick={() => setIsSearch(!isSearch)}>
                <i className="feather icon-search"/>
            </a>
            <div className="search-bar" style={{ display: searchStyle }}>
                <input type="text" className="form-control border-0 shadow-none" placeholder="Search hear"/>
                <button type="button" className="close" aria-label="Close" onClick={() => setIsSearch(!isSearch)}>
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </>);
};
export default NavSearch;
