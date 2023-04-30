import React, { useState } from 'react';
import { Button, Modal, ModalHeader, ModalBody, ModalFooter, FormGroup, Label, Input, Form, Col } from 'reactstrap';
import device_data from '@components/data/device_data.json'
import dynamic from "next/dynamic";
import axios, { AxiosResponse } from 'axios';
import ToolTip from './Tooltip';
const AnimatedNumbers = dynamic(() => import("react-animated-numbers"), {
    ssr: false,
});

interface PostData {
    technique_id: number;
    quantity: number;
    ghg_savings: number;
    created_by: string;
}


function Example() {
    const [modal, setModal] = useState(false);
    const [devices, setDevices] = useState<string[]>([])
    const [options, setOptions] = useState<string[]>([])

    const [num, setNum] = React.useState(0);
    const [device_type, setDType] = useState("")
    const [device, setDevice] = useState("")
    const [method_savings, setSavings] = useState(0)
    const [technique_id, setTechnique] = useState(0)


    const [count, setCount] = useState(0)
    const [count_state, setCountState] = useState(true)

    var dv = JSON.parse(JSON.stringify(device_data))


    

    function submit() {
        const postData: PostData = {
            technique_id: technique_id,
            quantity : count,
            ghg_savings : num,
            created_by : 'Vipin'
        };
    
        axios.post('http://127.0.0.1:80/submit_savings', postData)
            .then((response: AxiosResponse) => {
                console.log(response.data);
            })
            .catch((error: any) => {
                console.log(error);
            });
    
        toggle()
    }

    function toggle() {
        setModal(!modal);
        setDevices([]);
        setNum(0);
        setOptions([])
        setCount(0)
        setCountState(true)
    }

    function typeSelect(event: { target: { value: string; }; }) {
        setDType(event.target.value);
        setDevices(Object.keys(dv[event.target.value]["value"]));
        setOptions([])
        setCount(0)
        setCountState(true)
        calcSavings(0, 0)

    }

    function deviceSelect(event: { target: { value: string; }; }) {
        setDevice(event.target.value);
        setOptions(Object.keys(dv[device_type]["value"][event.target.value]["value"]))
        setCountState(false)
        setCount(0)
        calcSavings(0, 0)
        unCheck()
    }

    function countSelect(event: { target: { value: number; }; }) {
        setCount(event.target.value);
        calcSavings(event.target.value, method_savings)
    }

    function calcSavings(count: number, method_savings: number) {
        setNum(count * method_savings)
    }

    function methodSelect(event: { target: { value: string; }; }) {
        var savings = dv[device_type]["value"][device]["value"][event.target.value]["ghg_savings"]
        var technique_id = dv[device_type]["value"][device]["value"][event.target.value]["id"]
        setSavings(savings)
        calcSavings(count, savings)
        setTechnique(technique_id)
    }

    function unCheck() {
        var x = document.getElementsByName("radio2")
        var i;
        for (i = 0; i < x.length; i++) {
            x[i].checked = false;
        }
    }
    function getOptions(opt: string) {
        return (<FormGroup check>
            <Input
                name="radio2"
                type="radio"
                onChange={methodSelect}
                value={opt}
            />
            {' '}
            <div className='row'>
                <div className='col'>
                <Label check>
                {opt}
            </Label>
                </div>
                <div className='col'>
                <Label check>
                <ToolTip msg={dv[device_type]["value"][device]["value"][opt]["description"]} opt = {opt}/>
            </Label>
                </div>
            </div>
            
        </FormGroup>);
    }

    function AnimatedCounter() {
        return (
            <div>
                <AnimatedNumbers
                    includeComma
                    animateToNumber={num}
                    fontStyle={{ fontSize: 40 }}
                    locale="en-US"
                    configs={[
                        { mass: 1, tension: 220, friction: 100 },
                        { mass: 1, tension: 180, friction: 130 },
                        { mass: 1, tension: 280, friction: 90 },
                        { mass: 1, tension: 180, friction: 135 },
                        { mass: 1, tension: 260, friction: 100 },
                        { mass: 1, tension: 210, friction: 180 },
                    ]}
                ></AnimatedNumbers>
            </div>
        );
    }

    return (
        <div>
            <Button
                color="primary"
                type="button"
                onClick={toggle}
            >
                Add
            </Button>
            <Modal isOpen={modal} toggle={toggle} size='xl'>
                <ModalHeader toggle={toggle}>Add Item</ModalHeader>
                <ModalBody>
                    <div className="container">
                        <div className="row">
                            <div className="col">
                                <Form className='input_form' id='input_form'>
                                    <FormGroup row>
                                        <Label
                                            for="exampleSelect"
                                            sm={2}
                                        >
                                            Device Type
                                        </Label>
                                        <Col sm={10}>
                                            <Input
                                                bsSize="lg"
                                                id="exampleSelect"
                                                name="select"
                                                type="select"
                                                className='mt-2'
                                                onChange={typeSelect}
                                            >
                                                {Object.keys(dv).map((item: String) => <option>{item}</option>)}
                                            </Input>
                                        </Col>
                                    </FormGroup>
                                    <FormGroup row>
                                        <Label
                                            for="exampleEmail"
                                            sm={2}
                                        >
                                            Name
                                        </Label>
                                        <Col sm={10}>
                                            <Input
                                                bsSize="lg"
                                                id="exampleSelect"
                                                name="select"
                                                type="select"
                                                className='mt-2'
                                                onChange={deviceSelect}
                                            >

                                                {devices.map((item: String) => <option>{item}</option>)}
                                            </Input>
                                        </Col>
                                    </FormGroup>
                                    <FormGroup row>
                                        <Label
                                            for="exampleEmail"
                                            sm={2}
                                        >
                                            Quantity
                                        </Label>
                                        <Col sm={10}>
                                            <Input
                                                disabled={count_state}
                                                bsSize="lg"
                                                defaultValue={count}
                                                type="number"
                                                value={count}
                                                onChange={countSelect}
                                            />
                                        </Col>
                                    </FormGroup>
                                    <FormGroup
                                        row
                                        tag="fieldset"
                                    >
                                        <legend className="col-form-label col-sm-2">
                                            WRAP
                                        </legend>
                                        <Col sm={10}>
                                            {
                                                options.map((item: string) => getOptions(item))
                                            }


                                        </Col>
                                    </FormGroup>
                                </Form>
                            </div>
                            <div className="col" >
                                <div className='row' style={{
                                    display: "flex",
                                    alignItems: "center",
                                    justifyContent: "center"
                                }}>GHG Impact (KgCO2E)</div>
                                <div className='row' style={{
                                    display: "flex",
                                    alignItems: "center",
                                    height: "100%",
                                    justifyContent: "center"
                                }}>
                                <div className="container" style={{
                                    display: "flex",
                                    alignItems: "center",
                                    height: "100%",
                                    justifyContent: "center"
                                }}>
                                    <AnimatedCounter />
                                </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={submit}>
                        Add
                    </Button>{' '}
                    <Button color="secondary" onClick={toggle}>
                        Cancel
                    </Button>
                </ModalFooter>
            </Modal>
        </div>
    );
}

export default Example;

