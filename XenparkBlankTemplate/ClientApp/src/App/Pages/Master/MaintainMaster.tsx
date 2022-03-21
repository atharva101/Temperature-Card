import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Table, Alert, Spinner, Form, Button } from 'react-bootstrap';
import { connect } from 'react-redux';
import { useHistory, useLocation } from 'react-router';
import { IMaster } from '../../../models/master';
import { RootState } from '../../../store/action-types';


import { saveMaster, selectMaster, MasterState, fetchParentData } from '../../../store/master/master.action';

interface IMaintainMasterProps {
    master: MasterState;
    saveMaster: any,
    fetchParentData: any
}
const MaintainMaster = (props: IMaintainMasterProps) => {
    const [isEdit, setIsEdit] = useState(false);
    const location = useLocation();
    const [master, setMaster] = useState({} as IMaster);
    const history = useHistory();
    const [screen, setScreen] = useState('');
    const [parentscreen, setparentScreen] = useState('');
    useEffect(() => {
        setScreen(
            location.pathname == '/maintain-plant' ? 'Plant'
                : location.pathname == '/maintain-block' ? 'Block'
                    : location.pathname == '/maintain-area' ? 'Area'
                        : location.pathname == '/maintain-room' ? 'Room'
                            : location.pathname == '/maintain-product' ? 'Product'
                                : ''
        );
    }, []);
    useEffect(() => {
        setparentScreen(
            location.pathname == '/maintain-plant' ? ''
                : location.pathname == '/maintain-block' ? 'Plant'
                    : location.pathname == '/maintain-area' ? 'Block'
                        : location.pathname == '/maintain-room' ? 'Area'
                            : location.pathname == '/maintain-product' ? ''
                                : ''
        );
    }, []);

    useEffect(() => {
        if (props.master.selectedMasterId > 0) {
            setIsEdit(true);
            const tempMaster = (props.master.master as IMaster[]).find(x => x.Id == props.master.selectedMasterId);
            if (tempMaster) {
                setMaster(tempMaster);
            }
        }
        else setIsEdit(false);
    }, [props.master.selectedMasterId, props.master.master]);

    useEffect(() => {
        if (parentscreen != '') {
            props.fetchParentData(parentscreen.toLowerCase(), true);
        }
    }, [parentscreen]);

    const [validated, setValidated] = useState(false);
    const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();
        const form = event.currentTarget;
        if (form.checkValidity() === false) {

            event.stopPropagation();
        }
        setValidated(true);

        if (location.pathname == '/maintain-product') {
            props.saveMaster('product', master)
        }
        else if (location.pathname == '/maintain-plant') {
            props.saveMaster('plant', master)
        }
        else if (location.pathname == '/maintain-block') {
            props.saveMaster('block', master)
        }
        else if (location.pathname == '/maintain-area') {
            props.saveMaster('area', master)
        }
        else if (location.pathname == '/maintain-room') {
            props.saveMaster('room', master)
        }
    };

    useEffect(() => {
        if (props.master.status === 'saved') {
            if (location.pathname == '/maintain-product') {
                history.push('/product-master');
            }
            else if (location.pathname == '/maintain-plant') {
                history.push('/plant-master');
            }
            else if (location.pathname == '/maintain-block') {
                history.push('/block-master');
            }
            else if (location.pathname == '/maintain-area') {
                history.push('/area-master');
            }
            else if (location.pathname == '/maintain-room') {
                history.push('/room-master');
            }
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [props.master.status]);

    const handleInputChanges = (e: React.ChangeEvent<HTMLInputElement>) => {
        e.preventDefault();
        const { name, value } = e.target;
        setMaster({
            ...master,
            [name]: value,
        });

    }
    const handleSelectChanges = (e: any) => {
        e.preventDefault();
        const { name, value } = e.target;
        setMaster({
            ...master,
            [name]: value,
        });
    }

    return (<>
        <Row>
            <Col>
                <Card>
                    <Card.Header>
                        <Card.Title as="h5">{isEdit ? 'Edit ' + screen : 'Add ' + screen}</Card.Title>
                    </Card.Header>
                    <Card.Body>
                        {
                            props.master.error && props.master.error.length > 0
                                ?
                                <Alert variant="danger">
                                    {props.master.error}
                                </Alert>
                                : null
                        }
                        <Form noValidate validated={validated} onSubmit={handleSubmit}>
                            <Form.Row>
                                <Form.Group as={Col} md="6" >
                                    <Form.Label>
                                        {screen === "Plant" ? "Name" : "Code"}
                                    </Form.Label>
                                    <Form.Control
                                        required
                                        type="text"
                                        placeholder={screen === "Plant" ? "Name" : "Code"}
                                        name="Code"
                                        defaultValue={master.Code}
                                        onChange={handleInputChanges}
                                    />
                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                </Form.Group>
                                <Form.Group as={Col} md="6">
                                    <Form.Label>
                                        {
                                            screen === "Plant" ? "Location" : "Description"
                                        }

                                    </Form.Label>
                                    <Form.Control
                                        required
                                        type="text"
                                        placeholder={
                                            screen === "Plant" ? "Location" : "Description"
                                        }
                                        name="Description"
                                        defaultValue={master.Description}
                                        onChange={handleInputChanges}
                                    />
                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                </Form.Group>

                                {
                                    parentscreen && parentscreen != ''
                                        ?
                                        <Form.Group as={Col} md="6">
                                            <Form.Label>{parentscreen}</Form.Label>
                                            <select value={master.ParentId ?? -1} className="form-control" name="ParentId"
                                                onChange={handleSelectChanges}>
                                                <option value="">Select  {parentscreen}</option>
                                                {
                                                    props.master.parentData.map((p, index) => {
                                                        return <option key={index} value={p.Id}>{p.Code} - {p.Description}</option>
                                                    })
                                                }

                                            </select>
                                            <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                        </Form.Group>
                                        : null
                                }

                            </Form.Row>

                            {
                                props.master.status === 'inprogress' ?
                                    <Button type="submit" disabled={true}>Saving...</Button>
                                    :
                                    <Button type="submit">Submit form</Button>
                            }
                        </Form>
                    </Card.Body>
                </Card>
            </Col>
        </Row>

    </>);
};
const mapStateToProps = (state: RootState) => ({
    master: state.masterState as MasterState,

});
//this map actions to our props in this functional component
const mapActionsToProps = {
    saveMaster,
    fetchParentData
};
export default connect(mapStateToProps, mapActionsToProps)(MaintainMaster)
