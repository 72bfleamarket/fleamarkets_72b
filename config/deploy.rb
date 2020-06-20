# config valid for current version and patch releases of Capistrano
lock "3.14.0"
# config valid only for current version of Capistrano
set :linked_files, %w{ config/master.key }
# Capistranoのログの表示に利用する
set :application, "fleamarket_sample_72b"

# どのリポジトリからアプリをpullするかを指定する
set :repo_url, "git@github.com:72bfleamarket/fleamarket_sample_72b.git"

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads")

set :rbenv_type, :userex
set :rbenv_ruby, "2.5.1"

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ["publickey"],
                  keys: ["~/.ssh/fleamarket_72b.pem"]

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after "deploy:publishing", "deploy:restart"
namespace :deploy do
  desc "db_seed"
  task :restart do
    invoke "unicorn:restart"
  end

  desc "upload master.key"
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!("config/master.key", "#{shared_path}/config/master.key")
    end
  end
  before :starting, "deploy:upload"
  after :finishing, "deploy:cleanup"
end
