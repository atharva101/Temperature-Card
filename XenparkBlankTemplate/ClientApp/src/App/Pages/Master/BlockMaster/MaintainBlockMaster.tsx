import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Table, Alert, Spinner, Form, Button } from 'react-bootstrap';
import { connect } from 'react-redux';
import { useHistory, useLocation } from 'react-router';
import { IMaster } from '../../../../models/master';
import { RootState } from '../../../../store/action-types';


import { saveMaster, selectMaster, MasterState, fetchParentData } from '../../../../store/master/master.action';

interface IMaintainMasterProps {
    master: MasterState;
    saveMaster: any,
    fetchParentData: any
}
const MaintainBlockMaster = (props: IMaintainMasterProps) => {
    const [isEdit, setIsEdit] = useState(false);
    const location = useLocation();
    const [master, setMaster] = useState({} as IMaster);
    const history = useHistory();


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
        props.fetchParentData('plant', true);
    }, []);

    const [validated, setValidated] = useState(false);
    const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();
        const form = event.currentTarget;
        if (form.checkValidity() === false) {

            event.stopPropagation();
        }
        setValidated(true);

        props.saveMaster('block', master)
    };

    useEffect(() => {
        if (props.master.status === 'saved') {
            history.push('/block-master');
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
                        <Card.Title as="h5">{isEdit ? 'Edit Block' : 'Add Block'}</Card.Title>
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
                                <Form.Group as={Col} md="6">
                                    <Form.Label>
                                        Name
                                    </Form.Label>
                                    <Form.Control
                                        required
                                        type="text"
                                        placeholder="Name"
                                        name="Description"
                                        defaultValue={master.Description}
                                        onChange={handleInputChanges}
                                    />
                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                </Form.Group>
                                <Form.Group as={Col} md="6">
                                    <Form.Label>
                                        Reference Number
                                    </Form.Label>
                                    <Form.Control
                                        required
                                        type="text"
                                        placeholder="Reference Number"
                                        name="Column1"
                                        defaultValue={master.Column1}
                                        onChange={handleInputChanges}
                                    />
                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                </Form.Group>
                                <Form.Group as={Col} md="6">
                                    <Form.Label>
                                        Form Number
                                    </Form.Label>
                                    <Form.Control
                                        required
                                        type="text"
                                        placeholder="Form Number"
                                        name="Column2"
                                        defaultValue={master.Column2}
                                        onChange={handleInputChanges}
                                    />
                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                </Form.Group>
                                <Form.Group as={Col} md="6">
                                    <Form.Label>
                                        Version Number
                                    </Form.Label>
                                    <Form.Control
                                        required
                                        type="text"
                                        placeholder="Version Number"
                                        name="Column3"
                                        defaultValue={master.Column3}
                                        onChange={handleInputChanges}
                                    />
                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                </Form.Group>
                                <Form.Group as={Col} md="6">
                                    <Form.Label>Plant</Form.Label>
                                    <select value={master.ParentId ?? -1} className="form-control" name="ParentId"
                                        onChange={handleSelectChanges}>
                                        <option value="">Select  Plant</option>
                                        {
                                            props.master.parentData.map((p, index) => {
                                                return <option key={index} value={p.Id}>{p.Code} - {p.Description}</option>
                                            })
                                        }

                                    </select>
                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                </Form.Group>

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
export default connect(mapStateToProps, mapActionsToProps)(MaintainBlockMaster)
