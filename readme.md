# A dockerized glassfish 3.1.2.2 on jdk8

## Prerequisites

* GNU make
* curl
* docker

## Usage

```bash
make run
```

... wait for server and point your browser to https://localhost:4848/. (Accept the insecure certificate :/)

The makefile downloads glassfish 3.1.2.2 and converts it to a tgz. The Dockerfile
is based on a jdk8 runtime and contains a fix for the osgi configuration of glassfish
so it can start properly with jdk8. This glassfish version is built for jdk7. 

Additionally insecure tls algorithms must be reenabled to make the admin console work.

The fix is based on:

* [JDK issue](https://bugs.openjdk.java.net/browse/JDK-8020071)
* [stackoverflow thread about gf3 on jdk8](https://stackoverflow.com/questions/22462936/will-it-be-possible-to-use-java-8-on-glassfish-3)

## Caveats

So glassfish runs on jdk8, but still is not capable of loading java 8 classes due to
[missing java 8 class file format support in objectweb asm](https://itqna.net/questions/12911/error-making-application-deploy-glassfish-orgobjectwebasmcla).
The culprit seems to be located at /opt/glassfish3/glassfish/modules/asm-all-repackaged.jar.

## License
Copyright (c) 2022 by [Cornelius Buschka](https://github.com/cbuschka).

[MIT](./license.txt)

