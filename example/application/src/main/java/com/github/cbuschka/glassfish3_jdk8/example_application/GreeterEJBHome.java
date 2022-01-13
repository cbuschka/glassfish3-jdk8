package com.github.cbuschka.glassfish3_jdk8.example_application;

import javax.ejb.EJBHome;
import java.rmi.RemoteException;

public interface GreeterEJBHome extends EJBHome {
    GreeterEJBObject create() throws RemoteException;
}
