import React, { useEffect } from 'react';
import { useState } from 'react';
import { Row, Col, Card, Alert, Spinner, Form, Button, Table } from 'react-bootstrap';
import { connect, useDispatch } from 'react-redux';
import { IBatch, IBatchLogger } from '../../../models/batch';
import { IProduct } from '../../../models/product';
import { RootState } from '../../../store/action-types';
import { BatchState, saveBatch, selectBatch } from '../../../store/batch/batch.action';
import { fetchAllProducts } from '../../../store/product/product.action';
import { useHistory } from 'react-router';
import { useSelector } from '../../../store/reducer';

interface IMaintainBatchProps {
    batches: BatchState;
    products: IProduct[];
    source: string;

}
const MaintainBatch = (props: IMaintainBatchProps) => {
    const [isEdit, setIsEdit] = useState(false);
    const history = useHistory();
    const dispatch = useDispatch();
    const [batch, setBatch] = useState({} as IBatch);

    const roomId = useSelector(state => state.roomState.selectedRoomId);

    useEffect(() => {
        dispatch(fetchAllProducts(true));
    }, []);

    useEffect(() => {
        if (props.batches.selectedBatchId > 0) {
            setIsEdit(true);
            const tempBatch = props.batches.batches.find(x => x.Id === props.batches.selectedBatchId);
            if (tempBatch) {
                setBatch(tempBatch);
            }

        }
        else setIsEdit(false);


    }, [props.batches.selectedBatchId, props.batches.batches]);


    const [validated, setValidated] = useState(false);
    const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();
        const form = event.currentTarget;
        if (form.checkValidity() === false) {
            event.stopPropagation();
        }
        setValidated(true);
        let tempBatch = batch;
        if (props.source === 'room-view') {
            //setBatch({ ...batch, BatchLogger: [{ Id: 0, BatchId: batch.Id, RoomId: roomId, TimeStamp: '' }] })
            tempBatch = { ...batch, BatchLogger: [{ Id: 0, BatchId: 0, RoomId: roomId, TimeStamp: '' }] }
        }
        dispatch(saveBatch(tempBatch))

    };
    useEffect(() => {
        if (props.batches.status === 'saved')
            history.push(props.source === 'room-view' ? 'room-list' : '/batch');
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [props.batches.status]);

    const handleInputChanges = (e: React.ChangeEvent<HTMLInputElement>) => {
        e.preventDefault();
        const { name, value } = e.target;
        setBatch({
            ...batch,
            [name]: value,
        });
    }

    const handleSelectChanges = (e: any) => {
        e.preventDefault();
        const { name, value } = e.target;
        setBatch({
            ...batch,
            [name]: value,
        });
    }

    // const handleRoomSelectChanges = (e: any, index: number) => {
    //     setBatch({
    //         ...batch,
    //         BatchLogger: batch.BatchLogger.map((x, i) => i === index ? { ...x, RoomId: e.target.value } : x)
    //     });
    // }
    // const addNewRoom = () => {
    //     const tempBatch = JSON.parse(JSON.stringify(batch)) as IBatch;
    //     if (!tempBatch.BatchLogger) tempBatch.BatchLogger = [] as IBatchLogger[];
    //     tempBatch.BatchLogger.push({ Id: -1, RoomId: -1, BatchId: batch.Id, TimeStamp: null });
    //     setBatch(tempBatch);
    // }
    const redirectToBatchList = () => {
        dispatch(selectBatch(-1));
        history.push('/batch');
    }
    return (<>
        <Row>
            <Col>
                <Card>
                    <Card.Header>
                        <Card.Title as="h5"><i className="feather icon-arrow-left p-r-5" onClick={() => redirectToBatchList()} /> {isEdit ? 'Edit Batch' : 'Add Batch'}</Card.Title>
                    </Card.Header>
                    <Card.Body>
                        {
                            props.batches.error && props.batches.error.length > 0
                                ?
                                <Alert variant="danger">
                                    {props.batches.error}
                                </Alert>
                                : null
                        }
                        <Form noValidate validated={validated} onSubmit={handleSubmit}>
                            <Form.Row>
                                <Form.Group as={Col} md="6" >
                                    <Form.Label>Batch #</Form.Label>
                                    <Form.Control
                                        required
                                        type="text"
                                        placeholder="Batch #"
                                        name="BatchNumber"
                                        defaultValue={batch.BatchNumber}
                                        onChange={handleInputChanges}
                                    />
                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                </Form.Group>
                                <Form.Group as={Col} md="6">
                                    <Form.Label>Batch Size</Form.Label>
                                    <Form.Control
                                        required
                                        type="text"
                                        placeholder="Batch Size"
                                        name="BatchSize"
                                        defaultValue={batch.BatchSize}
                                        onChange={handleInputChanges}
                                    />
                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                </Form.Group>

                                <Form.Group as={Col} md="6">
                                    <Form.Label>Product</Form.Label>
                                    <select value={batch.ProductId ?? -1} className="form-control" name="ProductId"
                                        onChange={handleSelectChanges}>
                                        <option value="">--Select--</option>
                                        {
                                            props.products.map(product => {
                                                return <option key={product.Id} value={product.Id}>{product.Code + ' - ' + product.Description}</option>
                                            })
                                        }
                                    </select>
                                    <Form.Control.Feedback type="invalid">Required field</Form.Control.Feedback>
                                </Form.Group>
                            </Form.Row>

                            {/* <Table striped bordered hover responsive size="sm">
                                <thead>
                                    <tr>
                                        <th>
                                            Room
                                        </th>
                                        <th>
                                            <Button size="sm" variant="primary" className="btn-sm btn-round has-ripple" onClick={() => addNewRoom()}>
                                                <i className="feather icon-plus" />
                                            </Button></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {
                                        batch && batch.BatchLogger && batch.BatchLogger.map((batchLogger: IBatchLogger, index) => {
                                            return <tr key={index}>
                                                <td>
                                                    {
                                                        batchLogger.Id > 0
                                                            ?
                                                            roomMaster.filter(x => x.Id === batchLogger.RoomId).
                                                                map((x, i) => {
                                                                    return <span key={i}>{x.Code}-{x.Description}</span>
                                                                })
                                                            :
                                                            <select value={batchLogger.RoomId ?? -1} className="form-control" name="RoomId"
                                                                onChange={(e) => handleRoomSelectChanges(e, index)}>
                                                                <option value="">--Select--</option>
                                                                {
                                                                    roomMaster.map(rm => {
                                                                        return <option key={rm.Id} value={rm.Id}>{rm.Code + ' - ' + rm.Description}</option>
                                                                    })
                                                                }
                                                            </select>

                                                    }
                                                </td>
                                                <td>
                                                    <Button size="sm" variant="danger" className="btn-sm btn-round has-ripple" >
                                                        <i className="feather icon-delete" />
                                                    </Button>
                                                </td>
                                            </tr>
                                        })
                                    }
                                </tbody>
                            </Table> */}
                            <Button type="submit">Submit form</Button>
                        </Form>
                    </Card.Body>
                </Card>
            </Col>
        </Row>

    </>);
};
const mapStateToProps = (state: RootState) => ({
    batches: state.batchState as BatchState,
    products: state.productState.products as IProduct[]
});

export default connect(mapStateToProps)(MaintainBatch)
