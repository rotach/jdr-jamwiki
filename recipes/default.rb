#
# Cookbook Name:: jdr-jamwiki
# Recipe:: default

##### jdr-base - NTP, etc ######################################################
include_recipe "jdr-base"
################################################################################

##### tomcat runs on the JVM ###################################################
include_recipe "java"
################################################################################

##### tomcat ###################################################################
include_recipe "tomcat::default"
################################################################################

##### nginx ####################################################################
apt_package 'nginx' do
  action :install
end

file "/etc/nginx/nginx.conf" do
   action :delete
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :run, 'execute[reload-nginx]', :delayed
end

execute 'reload-nginx' do
  command 'service nginx reload'
  action :nothing
end

service 'nginx' do
  action :nothing
  supports :restart => false
  provider Chef::Provider::Service::Init::Debian
end
################################################################################

##### JAMwiki ##################################################################
directory 'create-jamwiki-dir' do
  path node['jdr-jamwiki']['install-dir']
  owner node[:tomcat]['user']
  group node[:tomcat]['group']
  action :create
end

aws_s3_file "#{node['jdr-jamwiki']['install-dir']}/jamwiki.war" do
  bucket "jdr-dependencies"
  remote_path "jamwiki-1.3.2.war"
  aws_access_key_id node['jdr-jamwiki']['aws_access_key_id']
  aws_secret_access_key node['jdr-jamwiki']['aws_secret_access_key']
  owner node[:tomcat]['user']
  group node[:tomcat]['group']
end

apt_package 'unzip' do
  action :install
end

execute "explode-jamwiki" do
  command "unzip -o jamwiki.war"
  cwd node['jdr-jamwiki']['install-dir']
  user node[:tomcat]['user']
  group node[:tomcat]['group']
  action :run
end

# MySQL connector lib
aws_s3_file "#{node['jdr-jamwiki']['install-dir']}/WEB-INF/lib/mysql-connector-java-5.1.34-bin.jar" do
  bucket "jdr-dependencies"
  remote_path "mysql-connector-java-5.1.34-bin.jar"
  aws_access_key_id node['jdr-jamwiki']['aws_access_key_id']
  aws_secret_access_key node['jdr-jamwiki']['aws_secret_access_key']
  owner node[:tomcat]['user']
  group node[:tomcat]['group']
end

# JAMWiki Properties file
cookbook_file "#{node['jdr-jamwiki']['install-dir']}/WEB-INF/classes/jamwiki.properties" do
  path "#{node['jdr-jamwiki']['install-dir']}/WEB-INF/classes/jamwiki.properties"
  owner node[:tomcat]['user']
  group node[:tomcat]['group']
  mode 00644
  action :create
end

# web context file
template '/etc/tomcat7/Catalina/localhost/wiki.xml' do
  source 'wiki.xml.erb'
  owner node[:tomcat]['user']
  group node[:tomcat]['group']
  mode 00644
end
################################################################################

##### NewRelic #################################################################
directory 'create-newrelic-dir' do
  path node[:tomcat]['base']
  owner node[:tomcat]['user']
  group node[:tomcat]['group']
  action :create
end

aws_s3_file "#{node[:tomcat]['base']}/newrelic-java-3.13.0.zip" do
  bucket "jdr-dependencies"
  remote_path "newrelic-java-3.13.0.zip"
  aws_access_key_id node['jdr-jamwiki']['aws_access_key_id']
  aws_secret_access_key node['jdr-jamwiki']['aws_secret_access_key']
  owner node[:tomcat]['user']
  group node[:tomcat]['group']
end

execute "explode-newrelic" do
  command "unzip -o newrelic-java-3.13.0.zip"
  cwd node[:tomcat]['base']
  user node[:tomcat]['user']
  group node[:tomcat]['group']
  action :run
end
################################################################################







