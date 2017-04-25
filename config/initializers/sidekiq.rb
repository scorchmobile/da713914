# require 'sidekiq'
# 
# # Set the Proper Redis Url
# redis_server_url = ENV["REDISCLOUD_URL"]  || 'redis://localhost:6379'
# 
# # Set up Redis
# redis_conn = proc {
#   Redis.new url: redis_server_url
# }
# 
# # Client Config
# Sidekiq.configure_client do |config|
#   config.redis = { url: redis_server_url, driver: :hiredis, size: 6 }
# end
# 
# # Server Config
# Sidekiq.configure_server do |config|
#   # Redis
#   config.redis = { url: redis_server_url, driver: :hiredis, size: 12 }
# 
#   # Database
#   database_url = ENV['DATABASE_URL'] || "postgres://#{ENV['DATABASE_USER']}:#{ENV['DATABASE_PASSWORD']}@localhost:5432/#{ENV['DATABASE_NAME']}"
#   database_pool = ENV['DATABASE_POOL'] || '100'
#   ActiveRecord::Base.establish_connection "#{database_url}?pool=#{database_pool}"
# end