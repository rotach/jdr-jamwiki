normal['jdr-jamwiki']['aws_access_key_id']      = '<KEY>'
normal['jdr-jamwiki']['aws_secret_access_key']  = '<SECRET>'

default['jdr-jamwiki']['install-dir'] = '/opt/jamwiki'

# Oracle JDK - Java 8
normal[:java][:install_flavor]                        = 'oracle'
normal[:java][:jdk_version]                           = '8'
normal[:java][:oracle][:accept_oracle_download_terms] = true

# Tomcat 7, HTTP port 8080, SSL port 4848
normal[:tomcat]['base_version'] = 7
normal[:tomcat]['port'] = 8080
normal[:tomcat]['ssl_port'] = 4848

# deploy tomcat manager webapps
normal[:tomcat]['deploy_manager_apps'] = false
# authbind required to bind to port < 1024
normal[:tomcat]['authbind'] = false

# Required to override base_version in attributes resolved at compile time.
# default base_version is 6.  When changing to 7 need to reeval attributes based on base_version.
normal[:tomcat]['user'] = "tomcat#{node["tomcat"]["base_version"]}"
normal[:tomcat]['group'] = "tomcat#{node["tomcat"]["base_version"]}"
normal[:tomcat]['home'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
normal[:tomcat]['base'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}"
normal[:tomcat]['config_dir'] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
normal[:tomcat]['log_dir'] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
normal[:tomcat]['tmp_dir'] = "/tmp/tomcat#{node["tomcat"]["base_version"]}-tmp"
normal[:tomcat]['work_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}"
normal[:tomcat]['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
normal[:tomcat]['webapp_dir'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"

normal[:tomcat]["java_options"] = "-Xms512M -Xmx512M -Djava.awt.headless=true"
normal[:tomcat]["catalina_options"] = "-javaagent:/var/lib/tomcat7/newrelic/newrelic.jar"