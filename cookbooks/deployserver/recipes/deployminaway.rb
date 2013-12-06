directory "#{node.default['bluebook']['webroot']}" do
  owner "user"
  recursive true
end

template "#{node.default['bluebook']['webroot']}/application.yml" do
  source "application.yml.erb"
  mode 0440
  owner "user"
end

