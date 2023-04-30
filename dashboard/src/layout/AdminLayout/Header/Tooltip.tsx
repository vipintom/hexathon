/* eslint react/no-multi-comp: 0, react/prop-types: 0 */
import React from 'react';
import { Button, Tooltip } from 'reactstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

export default class ToolTip extends React.Component {
  constructor(props) {
    super(props);

    this.toggle = this.toggle.bind(this);
    this.state = {
      tooltipOpen: false
    };
  }

  toggle() {
    this.setState({
      tooltipOpen: !this.state.tooltipOpen
    });
  }

  render() {
    return (
      <div>
        <Button id={this.props.opt} size="xs"></Button>
        <Tooltip placement="right" isOpen={this.state.tooltipOpen} target={this.props.opt} toggle={this.toggle}>
          {this.props.msg}
        </Tooltip>
      </div>
    );
  }
}
