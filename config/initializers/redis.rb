# redis_server_url = ENV["REDISCLOUD_URL"]  || 'redis://localhost:6379'

# $redis = Redis.new url: redis_server_url, driver: :hiredis

# $redis = ConnectionPool.new(size: 10) { Redis.new url: redis_server_url }