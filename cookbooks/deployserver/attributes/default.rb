default['bluebook']['ruby_version'] = '1.9.3'
default['bluebook']['package_version'] = 'p448'
default['bluebook']['combined'] = "#{default['bluebook']['ruby_version']}-#{default['bluebook']['package_version']}"

default['bluebook']['rails_version'] = '3.2.15'
default['bluebook']['passenger_version'] = '3.0.19'

default['bluebook']['gem_binary'] = "/usr/local/rvm/bin/gem-ruby-#{node.default['bluebook']['combined']}"

default['bluebook']['source'] = "source /usr/local/rvm/scripts/rvm"
default['bluebook']['gem_options'] = "--no-ri --no-rdoc"

default['bluebook']['app1'] = "your_rails_app"
default['bluebook']['webroot'] = "/var/www/"
default['bluebook']['total_url_app1'] = "#{default['bluebook']['webroot']}#{default['bluebook']['app1']}"
