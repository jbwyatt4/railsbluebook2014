cookbook_path ["cookbooks", "site-cookbooks"]
node_path     "nodes"
role_path     "roles"
data_bag_path "data_bags"
#encrypted_data_bag_secret "data_bag_key"

knife[:berkshelf_path] = "cookbooks"

cookbook_copyright "John B. Wyatt IV"
cookbook_license "apachev2"	# If you want an Free Software license.
				# Otherwise, just delete this line
cookbook_email "deployrailsbluebook@jbwyatt4.com"
