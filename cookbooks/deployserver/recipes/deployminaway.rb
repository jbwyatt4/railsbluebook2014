directory "/var/www" do
  owner "user"
  recursive true
end

directory "#{node.default['bluebook']['webroot']}#{node.default['bluebook']['app1']}" do
  owner "user"
  recursive true
  action :create
end

directory "#{node.default['bluebook']['webroot']}#{node.default['bluebook']['app1']}/current" do # /var/www/*/current
  owner "user"
  recursive true
  action :create
end

template "#{node.default['bluebook']['webroot']}#{node.default['bluebook']['app1']}/application.yml" do
  source "application.yml.erb"
  mode 0440
  owner "user"
end

