# A dockerized glassfish 3.1.2.2 on jdk8

### RESULTS: Glassfish 3 runs on jdk 8, but cannot deploy ears compiled in jdk 8 class file format

## Prerequisites

* GNU make
* curl
* docker

## Usage

```bash
make run
```

... wait for server and point your browser to https://localhost:4848/. (Accept the insecure certificate :/)

## Step 1: Make glassfish 3 start on jdk 8

The makefile downloads glassfish 3.1.2.2, applies the following patches and converts it to a tgz:

* fix osgi config glassfish3/glassfish/config/osgi.properties to run with jdk 8

```
jre-1.8=${jre-1.7}
```

So glassfish3 is able to start on jdk 8.

On container start insecure tls algorithms will be be reenabled to make the admin console work.

## Step 2: Glassfish 3 still cannot load jdk 8 compiled code

A possible fix is:

* replace asm-all 3.3 with 5.2 (which is jdk 8 class file format ready) in glassfish3/glassfish/modules/asm-all-repackaged.jar

UNFORTUNATELY THIS DOES NOT WORK!

```
[#|2022-01-13T20:33:22.342+0000|SEVERE|glassfish3.1.2|javax.enterprise.system.core.com.sun.enterprise.v3.server|_ThreadID=82;_ThreadName=Thread-40;|Exception while deploying the app [__admingui]|#]

[#|2022-01-13T20:33:22.343+0000|SEVERE|glassfish3.1.2|javax.enterprise.system.core.com.sun.enterprise.v3.server|_ThreadID=82;_ThreadName=Thread-40;|Implementing class
java.lang.IncompatibleClassChangeError: Implementing class
       at java.lang.ClassLoader.defineClass1(Native Method)
       at java.lang.ClassLoader.defineClass(ClassLoader.java:756)
       at org.apache.felix.framework.BundleWiringImpl$BundleClassLoader.findClass(BundleWiringImpl.java:2128)
       at org.apache.felix.framework.BundleWiringImpl.findClassOrResourceByDelegation(BundleWiringImpl.java:1432)
       at org.apache.felix.framework.BundleWiringImpl.access$400(BundleWiringImpl.java:72)
       at org.apache.felix.framework.BundleWiringImpl$BundleClassLoader.loadClass(BundleWiringImpl.java:1843)
       at java.lang.ClassLoader.loadClass(ClassLoader.java:351)
       at org.glassfish.hk2.classmodel.reflect.ParsingContext$Builder.build(ParsingContext.java:161)
       at com.sun.enterprise.v3.server.ApplicationLifecycle.getDeployableTypes(ApplicationLifecycle.java:505)
       at com.sun.enterprise.v3.server.ApplicationLifecycle.deploy(ApplicationLifecycle.java:351)
-       at com.sun.enterprise.v3.server.ApplicationLoaderService.processApplication(ApplicationLoaderService.java:375)
       at com.sun.enterprise.v3.admin.adapter.InstallerThread.load(InstallerThread.java:210)
       at com.sun.enterprise.v3.admin.adapter.InstallerThread.run(InstallerThread.java:108)
|#]
```

## Infos
The fixes are based on:

* [JDK issue](https://bugs.openjdk.java.net/browse/JDK-8020071)
* [stackoverflow thread about gf3 on jdk8](https://stackoverflow.com/questions/22462936/will-it-be-possible-to-use-java-8-on-glassfish-3)
* [missing java 8 class file format support in objectweb asm](https://itqna.net/questions/12911/error-making-application-deploy-glassfish-orgobjectwebasmcla)

## License
Copyright (c) 2022 by [Cornelius Buschka](https://github.com/cbuschka).

[MIT](./license.txt)

