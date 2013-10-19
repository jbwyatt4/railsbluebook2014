apt_package "nodejs"
apt_package "curl"
apt_package "git-core"
apt_package "build-essential"
apt_package "libcurl4-openssl-dev"
apt_package "zlib1g-dev"
 
execute "curl -L get.rvm.io | bash -s stable --ruby=#{node.default['bluebook']['combined']}" do
  not_if do
    ::File.directory?("/usr/local/rvm")
  end
  user "root"
end

execute "source" do
  command "echo '#{node.default['bluebook']['source']}' >> /etc/bash.bashrc; echo 'export rvmsudo_secure_path=0' >> /etc/bash.bashrc; #{node.default['bluebook']['source']}; rvm use #{node.default['bluebook']['combined']} --default; /bin/bash --login; touch /etc/chefflag-source"
  not_if do
    ::File.exists?('/etc/chefflag-source')
  end
  user "root"
end

execute "ruby -v" do
  command "bash -c '#{node.default['bluebook']['source']}; ruby -v'"
  user "root"
end

gem_package "passenger" do
  package_name "passenger"
  version node.default['bluebook']['passenger_version']
  gem_binary node.default['bluebook']['gem_binary']
  options node.default['bluebook']['gem_options']
end

gem_package "rails" do
  package_name "rails"
  version node.default['bluebook']['rails_version']
  gem_binary node.default['bluebook']['gem_binary']
  options node.default['bluebook']['gem_options']
end

execute "Use Passenger to Install Nginx" do
  command "bash -c 'source /usr/local/rvm/scripts/rvm; passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx'"
  user "root"
  not_if do
    ::File.directory?("/opt/nginx")
  end
end

execute "Fetch Init Scripts" do
  command "wget -O init-deb.sh http://library.linode.com/assets/660-init-deb.sh; sudo mv init-deb.sh /etc/init.d/nginx; sudo chmod +x /etc/init.d/nginx; sudo /usr/sbin/update-rc.d -f nginx defaults; touch /etc/chefflag-fetch"
  user "root"
  not_if do
    ::File.exists?('/etc/chefflag-fetch')
  end
end

template "/opt/nginx/conf/nginx.conf" do
  source "nginx.conf.erb"
  mode 0440
  owner "root"
  group "root"
  notifies :run, 'execute[nginx-restart]', :immediately
end

template "/etc/default/nginx" do
  source "nginx.erb"
  mode 0440
  owner "root"
  group "root"
  notifies :run, 'execute[nginx-restart]', :immediately
end

execute "nginx-restart" do
  command "/etc/init.d/nginx restart; true" # we add true to end to return 0
                                            # since this script keeps
                                            # returning 1
  user "root"
  action :nothing
end
