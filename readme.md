# A dockerized glassfish 3.1.2.2 on jdk8

## Prerequisites

* GNU make
* curl
* docker

## Usage

```bash
make run
```

The makefile downloads glassfish 3.1.2.2 and converts it to a tgz. The Dockerfile
is based on a jdk8 runtime and contains a fix for the osgi configuration of glassfish
so it can start properly with jdk8. This glassfish version is built for jdk7. 
Additionally insecure tls algorithms will be reenabled to make the admin console work.

The fix is based on:

* [JDK issue](https://bugs.openjdk.java.net/browse/JDK-8020071)
* [stackoverflow thread about gf3 on jdk8](https://stackoverflow.com/questions/22462936/will-it-be-possible-to-use-java-8-on-glassfish-3)

## License
Copyright (c) 2022 by [Cornelius Buschka](https://github.com/cbuschka).

[MIT](./license.txt)

