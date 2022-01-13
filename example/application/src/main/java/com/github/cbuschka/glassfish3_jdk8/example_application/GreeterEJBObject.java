package com.github.cbuschka.glassfish3_jdk8.example_application;

import javax.ejb.EJBObject;
import java.rmi.RemoteException;

public interface GreeterEJBObject extends EJBObject {
    String getMessage() throws RemoteException;
}
