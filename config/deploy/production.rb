server 'ec2-35-183-126-4.ca-central-1.compute.amazonaws.com', user: 'deploy', roles: %w(app web)

set :stage, :production
set :branch, ENV['REVISION'] || ENV['BRANCH_NAME'] || :master
set :linked_files, %w(config/puma.rb config/application.yml)
