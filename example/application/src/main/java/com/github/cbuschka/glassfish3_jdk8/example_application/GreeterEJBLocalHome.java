package com.github.cbuschka.glassfish3_jdk8.example_application;

import javax.ejb.EJBLocalHome;

public interface GreeterEJBLocalHome extends EJBLocalHome {
    GreeterEJBLocalObject create();
}
