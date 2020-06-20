server "54.238.15.114", user: "ec2-user", roles: %w{app db web}
set :rails_env, "production"
set :unicorn_rack_env, "production"
