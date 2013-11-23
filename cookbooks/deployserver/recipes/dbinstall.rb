apt_package "postgresql"
apt_package "libpq-dev"
# A nice tool for beginners
# apt_package "pgadmin3"

# \l list databases
# \du list all roles

template "/etc/postgresql/9.1/main/pg_hba.conf" do
  source "pg_hba.conf.erb"
  mode 00600
  owner "postgres"
  group "postgres"
  notifies :run, 'execute[postgresql-restart]', :immediately # We need to restart postgresql
end

######
# Grep Guide
# 
# -c returns 1 on a successful match
# -w requires the match be a whole word: grep -w "match" will not be okay with "matches"
######

# Change the automatically created postgres user's password
user "postgres" do
  password node.default[:bluebook][:postgres_password]
  action :modify
end

# Now change the postgres role password
execute "Change postgres role password" do
  command "psql -U postgres -c \"ALTER USER postgres WITH ENCRYPTED PASSWORD '#{node.default[:bluebook][:db_role_postgres_password]}';\""
  user "postgres"
end

# You should create a new role for each new database
# As an exercise for the reader try to DRY out creating the role and the db
execute "Setup deploy role" do
  # I'm a block of code!
  check = <<-EOH
  psql -U postgres -c "select * from pg_roles where rolname='#{node.default[:bluebook][:db_role_deploy_username]}'" | grep -cw #{node.default[:bluebook][:db_role_deploy_username]}
  EOH
  # End block.
  user "postgres"
  command "psql -U postgres -c \"CREATE ROLE #{node.default[:bluebook][:db_role_deploy_username]} LOGIN ENCRYPTED PASSWORD \'#{node.default[:bluebook][:db_role_deploy_password]}\';\"" # postgres -c does not like '' and you need to use "" to filter.
  not_if check, :user => 'postgres' # Without this :user part the command will be ignored
end

execute "Setup your_rails_db database" do
  checked = <<-EOH
  psql -U postgres -c "select * from pg_database WHERE datname='#{node.default[:bluebook][:db_role_deploy_database]}'" | grep -cw #{node.default[:bluebook][:db_role_deploy_database]}
  EOH
  user "postgres"
  command "createdb -O #{node.default[:bluebook][:db_role_deploy_username]} #{node.default[:bluebook][:db_role_deploy_database]}"
  not_if checked, :user => 'postgres' # Without this :user part the command will be ignored
  notifies :run, 'execute[postgresql-restart]', :immediately
end

execute "postgresql-restart" do
  command "service postgresql reload"
  user "root"
  action :nothing
end
