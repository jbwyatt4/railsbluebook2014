# Sources for Deploy Rails BlueBook

## Updates

Hello!

The rvm code is currently broken due to a change in how gem binaries are handled. I am working to fix this. However, this is the second time that changes in RVM/rubygems has broken this script. I'm looking into alternatives for the 2015 edition. If anyone manages to fix this, please send me a patch.

## Introduction

This repo contains a complete VPS recipe that deploys a Postgres/Rails/Nginx stack on Ubuntu LTS releases. For testing purposes a sample app in my your_rails_app repo is downloaded as an example. You can easily change this in the attributes file.

Some other notes
- the database creation is intelligent: it will query for both the current role and database names and can be changed with a single line of code.
- one time setups usually mark their progress with file marker in /etc
- both recipes for a Chef install and a Mina install is included.

While I feel my code is alot simpler than the more advanced Opscode recipes, it can still be quite intimating for those who are not used to Chef or Ruby DSL. If your in this group, you can acquire a copy of my Deploy Rails Bluebook that will show practically everything you need to get started beyond simple Rails skills.

Check out these links for a copy:
Leanpub:
https://leanpub.com/deployrailsbluebook/
Amazon:
http://www.amazon.com/Deploy-Rails-BlueBook-2014-Edition-ebook/dp/B00GZ9SNKY

## Security

By default, this deploy IS NOT SECURE. The vagrant public key is installed into the user account that is created. This allows people to quickly test to make sure my repo works on Vagrant using the vagrant public key for the automated setup. However with a public server this allows EVERYONE access to your deploy. In a production environment, and my book goes over this (you can also easily find this online), you need to generate your own public key and have it installed on the server.

IF YOU PLAN TO DEPLOY THIS APP OUTSIDE YOUR INTERNAL NETWORK CHANGE THE PUBLIC KEY IN recipes/deployserver/attributes/default.rb
OR EVERYONE WILL HAVE ACCESS TO YOUR SERVER.

## License

Apache 2.0

## Thanks

I like to give thanks to Opscode for releasing and maintaining Chef under a Free Software license. I feel Chef and Knife offers one of the best automation solutions today and I wouldn't have written this book if it wasn't. Also, thanks again to Opscode for the many Chef recipes available on Github.
