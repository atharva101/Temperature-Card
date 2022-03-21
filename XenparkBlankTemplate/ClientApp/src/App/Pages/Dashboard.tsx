import React, { useState } from 'react';
import { Row, Col, Card } from 'react-bootstrap';
import { FullScreen, useFullScreenHandle } from "react-full-screen";
const Dashboard = () => {
    const fullScreenHandle = useFullScreenHandle();
    const [isFullScreen, setFullScreen] = useState(false);
    const enterFullScreen = () => {
        setFullScreen(true);
        fullScreenHandle.enter();
    };
    const exitFullScreen = () => {
        setFullScreen(false);
        fullScreenHandle.exit();
    };

    return (<>
        <FullScreen handle={fullScreenHandle}>
            <Row>
                <Col xl={12} md={12}>
                    <Row>
                        <Col xs={12} sm={12}>
                            <Card className="m-b-0">
                                <Card.Header>
                                    <h5>Room Status</h5>
                                    <div className="card-header-right p-3" style={{ 'cursor': 'pointer' }}>
                                        {!isFullScreen ?
                                            <i className="fas fa-expand f-18" onClick={enterFullScreen}></i>
                                            :
                                            <i className="fas fa-compress f-18" onClick={exitFullScreen}></i>
                                        }
                                    </div>



                                </Card.Header>

                                <Card.Body className="pb-0">
                                    <Row className="text-center m-25">
                                        <Col xs={12} sm={12}>
                                            <h1>Room # 1001</h1>
                                            <h4>Room Description Here</h4>
                                        </Col>
                                    </Row>
                                    <Row className="text-center m-25">
                                        <Col xs={12} sm={12}>
                                            <h3>P5489 - ALFA-MAXICAL SOFT GEL CAPSULE </h3>
                                        </Col>
                                    </Row>
                                    <Row className="text-center m-25">
                                        <Col xs={12} sm={6}>
                                            <h3> Batch # B1001</h3>
                                        </Col>
                                        <Col xs={12} sm={6}>
                                            <h3>Batch Size : 21</h3>
                                        </Col>
                                    </Row>

                                </Card.Body>
                                <Card.Footer className="bg-primary ">
                                    <Row className="text-center text-white">
                                        <Col>
                                            <h1 className="m-0 text-white">In Progress</h1>
                                        </Col>
                                    </Row>
                                </Card.Footer>
                            </Card>
                        </Col>
                    </Row>
                    <Row>
                        <Col>
                            <Card >
                                <Card.Body className="pb-0">
                                    <Row className="text-center m-25">

                                        <Col xs={12} sm={3}>
                                            <Card>
                                                <Card.Body>
                                                    <Row className="align-items-center">
                                                        <Col sm={8}>
                                                            <h6 className="text-muted m-b-0">10:00 AM</h6>
                                                            <h6 className="text-muted m-b-0">02:00 PM</h6>
                                                        </Col>
                                                        <Col sm={4} className="text-right">
                                                            <i className="feather icon-bar-chart-2 f-28" />
                                                        </Col>
                                                    </Row>
                                                </Card.Body>
                                                <Card.Footer className="bg-c-yellow">
                                                    <Row className="row align-items-center">
                                                        <Col>
                                                            <h6 className="text-white m-b-0">% change</h6>
                                                        </Col>
                                                    </Row>
                                                </Card.Footer>
                                            </Card>
                                        </Col>
                                        <Col xs={12} sm={3}>
                                            <Card>
                                                <Card.Body>
                                                    <Row className="align-items-center">
                                                        <Col sm={8}>
                                                            <h6 className="text-muted m-b-0">10:00 AM</h6>
                                                            <h6 className="text-muted m-b-0">02:00 PM</h6>
                                                        </Col>
                                                        <Col sm={4} className="text-right">
                                                            <i className="feather icon-file-text f-28" />
                                                        </Col>
                                                    </Row>
                                                </Card.Body>
                                                <Card.Footer className="bg-c-green">
                                                    <Row className="row align-items-center">
                                                        <Col>
                                                            <h6 className="text-white m-b-0">% change</h6>
                                                        </Col>
                                                    </Row>
                                                </Card.Footer>
                                            </Card>
                                        </Col>
                                        <Col xs={12} sm={3}>
                                            <Card>
                                                <Card.Body>
                                                    <Row className="align-items-center">
                                                        <Col sm={8}>
                                                            <h6 className="text-muted m-b-0">10:00 AM</h6>
                                                            <h6 className="text-muted m-b-0">02:00 PM</h6>
                                                        </Col>
                                                        <Col sm={4} className="text-right">
                                                            <i className="feather icon-bar-chart-2 f-28" />
                                                        </Col>
                                                    </Row>
                                                </Card.Body>
                                                <Card.Footer className="bg-c-yellow">
                                                    <Row className="row align-items-center">
                                                        <Col>
                                                            <h6 className="text-white m-b-0">% change</h6>
                                                        </Col>
                                                    </Row>
                                                </Card.Footer>
                                            </Card>
                                        </Col>
                                        <Col xs={12} sm={3}>
                                            <Card>
                                                <Card.Body>
                                                    <Row className="align-items-center">
                                                        <Col sm={8}>
                                                            <h6 className="text-muted m-b-0">10:00 AM</h6>
                                                            <h6 className="text-muted m-b-0">02:00 PM</h6>
                                                        </Col>
                                                        <Col sm={4} className="text-right">
                                                            <i className="feather icon-file-text f-28" />
                                                        </Col>
                                                    </Row>
                                                </Card.Body>
                                                <Card.Footer className="bg-c-green">
                                                    <Row className="row align-items-center">
                                                        <Col>
                                                            <h6 className="text-white m-b-0">% change</h6>
                                                        </Col>
                                                    </Row>
                                                </Card.Footer>
                                            </Card>
                                        </Col>

                                    </Row>
                                </Card.Body>

                            </Card>
                        </Col>
                    </Row>
                </Col>
            </Row>
        </FullScreen>

    </>);
};
export default Dashboard;
