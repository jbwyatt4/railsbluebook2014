directory "#{node.default['bluebook']['total_url_app1']}" do # /var/www/*/current
  owner "user"
  recursive true
  action :create
end

# do not use ~... in vagrant, will goto vagrant user
execute "git clone git://github.com/jbwyatt4/#{node.default['bluebook']['app1']}.git /home/user/#{node.default['bluebook']['app1']}" do
  user "user"
  not_if do
    ::File.directory?("/home/user/#{node.default['bluebook']['app1']}")
  end
end

execute "cd /home/user/#{node.default['bluebook']['app1']}; git pull" do
  user "user"
end

execute "Remove old copy of app from webroot" do
  command "rm -rf #{node.default['bluebook']['total_url_app1']}/*"
  user "root"
  only_if do
    ::File.directory?("#{node.default['bluebook']['total_url_app1']}")
  end
  #action :nothing
end

execute "Copy app over to webroot" do
  command "cp -r /home/user/#{node.default['bluebook']['app1']}/* #{node.default['bluebook']['total_url_app1']}"
  user "user"
  not_if do
    ::File.directory?("#{node.default['bluebook']['total_url_app1']}/Gemfile")
  end
  #action :nothing
end

# Please beware of the hardcoded user
execute "Change permissions of the deploy folder for the hard coded user-chmod." do
  command "chmod -R 755 #{node.default['bluebook']['total_url_app1']}"
  user "root"
end

execute "Change permissions of the deploy folder for the hard coded user-chown." do
  command "chown -R 755 #{node.default['bluebook']['total_url_app1']}"
  user "root"
end

execute "Change permissions of the deploy folder for the hard coded user-chown user." do
  command "chown -R user #{node.default['bluebook']['total_url_app1']}"
  user "root"
end

execute "Install the gems for your app" do
  command "bash -c '#{node.default['bluebook']['source']}; cd #{node.default['bluebook']['total_url_app1']}; bundle install'" 
  user "root"
end

template "#{node.default['bluebook']['total_url_app1']}/config/application.yml" do
  source "application.yml.erb"
  mode 0440
  owner "user"
end

execute "Deploy Rails app" do
  command "bash -c '#{node.default['bluebook']['source']}; cd #{node.default['bluebook']['total_url_app1']}; rake db:migrate RAILS_ENV=\"production\"; rake assets:precompile RAILS_ENV=\"production\"'"
  user "user"
  notifies :run, 'execute[nginx-restart]', :immediately
end

execute "nginx-restart" do
  command "/etc/init.d/nginx restart; true"
  user "root"
  action :nothing
end
