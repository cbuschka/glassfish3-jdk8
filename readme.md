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

The makefile downloads glassfish 3.1.2.2, applies the following patches and converts it to a tgz:

* fix osgi config glassfish3/glassfish/config/osgi.properties to run with jdk 8

```
jre-1.8=${jre-1.7}
```

* replace asm-all 3.3 with 5.2 (which is jdk 8 class file format ready) in glassfish3/glassfish/modules/asm-all-repackaged.jar

On container start insecure tls algorithms will be be reenabled to make the admin console work.

The fix is based on:

* [JDK issue](https://bugs.openjdk.java.net/browse/JDK-8020071)
* [stackoverflow thread about gf3 on jdk8](https://stackoverflow.com/questions/22462936/will-it-be-possible-to-use-java-8-on-glassfish-3)
* [missing java 8 class file format support in objectweb asm](https://itqna.net/questions/12911/error-making-application-deploy-glassfish-orgobjectwebasmcla)

## License
Copyright (c) 2022 by [Cornelius Buschka](https://github.com/cbuschka).

[MIT](./license.txt)

