#--------IMPORTANT! CHANGE OR OVERRIDE-----------
default[:bluebook][:user_password] = "$1$.MZ8xPWB$/e/nAWc4C2zidbSVN9M/2/" #password
default[:bluebook][:postgres_password] = "$1$.MZ8xPWB$/e/nAWc4C2zidbSVN9M/2/" #password
default[:bluebook][:db_role_postgres_password] = "postgres_role_password"
default[:bluebook][:db_role_deploy_password] = "role_password"
default[:bluebook][:app1_secret_token] = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
# Vagrant public key-please, please, please, change this or set to empty string.
default[:bluebook][:authorized_keys] = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
"
#-----------------

# Versions
default['bluebook']['ruby_version'] = '1.9.3'
default['bluebook']['package_version'] = 'p484'
default['bluebook']['rails_version'] = '3.2.16'
default['bluebook']['passenger_version'] = '4.0.26'
default['bluebook']['rvm_version'] = 'stable' # 'stable'

# Locations and other settings
default['bluebook']['combined'] = "#{default['bluebook']['ruby_version']}-#{default['bluebook']['package_version']}"
default['bluebook']['gem_binary'] = "/usr/local/rvm/bin/gem-ruby-#{node.default['bluebook']['combined']}"

#default['bluebook']['source'] = "source /usr/local/rvm/scripts/rvm"
default['bluebook']['source'] = "source /etc/profile.d/rvm.sh"
default['bluebook']['gem_options'] = "--no-ri --no-rdoc"

default['bluebook']['app1'] = "your_rails_app"
default['bluebook']['webroot'] = "/var/www"
# The current directory is used by Mina to link to the current version of the web app.
default['bluebook']['total_url_app1'] = "#{default['bluebook']['webroot']}/#{default['bluebook']['app1']}/current"

default[:bluebook][:db_role_deploy_username] = "deploy"
default[:bluebook][:db_role_deploy_database] = "your_rails_db"
