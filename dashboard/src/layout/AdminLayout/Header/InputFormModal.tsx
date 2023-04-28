import React, { useState } from 'react';
import { Button, Modal, ModalHeader, ModalBody, ModalFooter, FormGroup, Label, Input, Form, Col } from 'reactstrap';
import device_data from '@components/data/device_data.json'
import dynamic from "next/dynamic";
const AnimatedNumbers = dynamic(() => import("react-animated-numbers"), {
    ssr: false,
});

function Example() {

    const [modal, setModal] = useState(false);
    const [devices, setDevices] = useState<string[]>([])
    const [options, setOptions] = useState<string[]>([])

    const [num, setNum] = React.useState(0);
    const [device_type, setDType] = useState("")
    const [device, setDevice] = useState("")
    const [method_savings, setSavings] = useState(0)


    const [count, setCount] = useState(0)
    const [count_state, setCountState] = useState(true)

    var dv = JSON.parse(JSON.stringify(device_data))
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
        setDevices(Object.keys(dv[event.target.value]));

        setOptions([])
        setCount(0)
        setCountState(true)
        calcSavings(0, 0)

    }

    function deviceSelect(event: { target: { value: string; }; }) {
        setDevice(event.target.value);
        setOptions(Object.keys(dv[device_type][event.target.value]))
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
        setNum(count * 10 * method_savings)
    }

    function methodSelect(event: { target: { value: number; }; }) {
        setSavings(event.target.value)
        calcSavings(count, event.target.value)
    }

    function unCheck() {
        var x = document.getElementsByName("radio2")
        var i;
        for (i = 0; i < x.length; i++) {
            x[i].checked = false;
        }
    }
    function getOptions(opt: string) {
        var savings = dv[device_type][device][opt]
        return (<FormGroup check>
            <Input
                name="radio2"
                type="radio"
                onChange={methodSelect}
                value={savings}
            />
            {' '}
            <Label check>
                {opt + "( " + savings + "%)"}
            </Label>
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

                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={toggle}>
                        Do Something
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

