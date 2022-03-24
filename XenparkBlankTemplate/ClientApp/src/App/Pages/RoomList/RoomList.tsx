import React, { useEffect } from 'react';
import { Row, Col, Card, } from 'react-bootstrap';
import { useState } from 'react';
import TableView from './TableView'
import TileView from './TileView';
import { connect } from 'react-redux';
import { RootState } from '../../../store/action-types';
import { IUser } from '../../../models/user';
import { useHistory } from 'react-router';

interface IRoomProps {
    loggedInUser: IUser,
}

export interface IFilter {
    plantId: number;
    blockId: number;
    areaId: number;
    room: string;
    batch: string;
    product: string;
    statusId: number;
}

const RoomList = (props: IRoomProps) => {
    const history = useHistory();
    const [isTileView, setTileView] = useState(false);

    const tileView = (value: boolean) => {
        setTileView(value);
    }

    useEffect(() => {
        if (props.loggedInUser && props.loggedInUser.RoleId === -1) {
            history.push('/room-dashboard');
        }
    }, [props.loggedInUser]);
    
    return (<>
        <Row>
            <Col>
                <Card>
                    <Card.Header>
                        <Card.Title as="h5">Room List</Card.Title>
                        <div className="card-header-right p-3" style={{ 'cursor': 'pointer' }}>
                            {isTileView ?

                                <i className="fas fa-table f-18" onClick={() => tileView(false)}></i>
                                :
                                <i className="feather icon-grid f-18" onClick={() => tileView(true)}></i>
                            }
                        </div>
                    </Card.Header>
                    <Card.Body>
                        {
                            isTileView
                                ?
                                <TileView />
                                : <TableView />
                        }
                    </Card.Body>
                </Card>
            </Col>
        </Row>

    </>);
};

const mapStateToProps = (state: RootState) => ({
    loggedInUser: state.authentication.loggedInUser as any,

});

export default connect(mapStateToProps)(RoomList)

//export default RoomList; //connect(mapStateToProps)(RoomList)