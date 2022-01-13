package com.github.cbuschka.glassfish3_jdk8.example_application;

import javax.ejb.EJBLocalObject;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;

public interface GreeterEJBLocalObject extends EJBLocalObject {
    String getMessage();
}
