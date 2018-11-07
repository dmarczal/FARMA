set :stage, :production

server '68.183.119.242', roles: %w(app web db), primary: true, user: 'root'
set :rails_env, "production"
