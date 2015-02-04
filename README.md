jdr-jamwiki Cookbook
===========================
Cookbook for building an JAMwiwk machine.

Requirements
------------

#### packages
- `java` - Apache Tomcat is on the JVM

#### cookbooks
- `apache tomcat` - Includes Supermarket Tomcat cookbook

Attributes
----------

#### 2lem-thingworx::default
| Key                                  | Type    | Description                     | Default                       |
| ------------------------------------ | ------- | ------------------------------- | -----------------------------:|
|normal[:tomcat]['base_version']       | Integer | Tomcat Version                  | 7                             |
|normal[:tomcat]['port']               | Integer | HTTP listener port              | 8080                          |
|normal[:tomcat]['ssl_port']           | Integer | HTTPS listener port             | 4848                          |
|normal[:tomcat]['deploy_manager_apps']| Boolean | Deploy the tomcat manager apps? | true                          |
|normal[:tomcat]['authbind']           | Boolean | Install authbind for ports < 1024 ? | false                     |


Usage
-----

#### jdr-jamwiki::default

License and Authors
-------------------
Authors: John Rotach - rotach@gmail.com