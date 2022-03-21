import React from 'react';
import { Row, Col, Card,} from 'react-bootstrap';
import { useState } from 'react';
import TableView from './TableView'
import TileView from './TileView';

interface IRoomProps {
    
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
    const [isTileView, setTileView] = useState(false);

    const tileView = (value: boolean) => {
        setTileView(value);
    }
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



export default RoomList; //connect(mapStateToProps)(RoomList)