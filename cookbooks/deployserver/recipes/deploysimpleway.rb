directory "/var/www" do
  owner "user"
  recursive true
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
  command "rm -rf #{node.default['bluebook']['total_url_app1']}"
  user "root"
  only_if do
    ::File.directory?("#{node.default['bluebook']['total_url_app1']}")
  end
end

execute "Copy app over to webroot" do
  command "cp -r /home/user/#{node.default['bluebook']['app1']} #{node.default['bluebook']['webroot']}"
  user "user"
  not_if do
    ::File.directory?("#{node.default['bluebook']['total_url_app1']}")
  end
end

# Please beware of the hardcoded user
execute "chmod -R 755 #{node.default['bluebook']['total_url_app1']}; chown -R 755 #{node.default['bluebook']['total_url_app1']}; chown -R user #{node.default['bluebook']['total_url_app1']}" do
  user "root"
end

execute "Root setup" do
  command "bash -c '#{node.default['bluebook']['source']}; cd #{node.default['bluebook']['total_url_app1']}; bundle install'" 
  user "root"
end

execute "Deploy rails app" do
  command "bash -c '#{node.default['bluebook']['source']}; cd #{node.default['bluebook']['total_url_app1']}; rake db:migrate RAILS_ENV='production'; rake assets:precompile'"
  user "user"
  notifies :run, 'execute[nginx-restart]', :immediately
end

execute "nginx-restart" do
  command "/etc/init.d/nginx restart; true"
  user "root"
  action :nothing
end
