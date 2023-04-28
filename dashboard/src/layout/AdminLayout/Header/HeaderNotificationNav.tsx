import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faBell, faEnvelope, IconDefinition } from '@fortawesome/free-regular-svg-icons'
import {
  faBasketShopping,
  faChartBar,
  faGaugeHigh,
  faList,
  faUserMinus,
  faUserPlus,
  faCirclePlus
} from '@fortawesome/free-solid-svg-icons'
import {
  Badge, Dropdown, Nav, NavLink, ProgressBar,
} from 'react-bootstrap'
import Link from 'next/link'
import React, { PropsWithChildren } from 'react'
import Image from 'next/image'
import { Button, Container } from 'react-bootstrap'
import Example  from '@layout/AdminLayout/Header/InputFormModal'

type ItemWithIconProps = {
  icon: IconDefinition;
} & PropsWithChildren

const ItemWithIcon = (props: ItemWithIconProps) => {
  const { icon, children } = props

  return (
    <>
      <FontAwesomeIcon className="me-2" icon={icon} fixedWidth />
      {children}
    </>
  )
}

export default function HeaderNotificationNav() {
  return (
    <Nav>
      <Nav.Item>
        <Example />
      </Nav.Item>
    </Nav>
  )
}
