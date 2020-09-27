require 'discordrb'
require 'rest-client'
require 'json'
require 'yaml'
require 'open-uri'
require 'dblruby'
require 'rufus-scheduler'
require 'coinbase/wallet'
require 'sentry-raven'
require 'jwt'
puts 'All dependencies loaded'

CONFIG = YAML.load_file('config.yaml')
puts 'Config loaded from file'

DBL = DBLRuby.new(CONFIG['dbotsorg'], CONFIG['client_id'])
puts 'Properly Instantiated DBL!'

prefixes = ["<@#{CONFIG['client_id']}>", 'hq,', 'HQ,', 'hq', 'HQ', 'Hq', 'Hq,'].freeze

Client = Coinbase::Wallet::Client.new(api_key: CONFIG['cb_api'], api_secret: CONFIG['cb_secret'])

Raven.configure do |config|
  config.dsn = CONFIG['raven']
end

Bot = Discordrb::Commands::CommandBot.new(token: CONFIG['NzU5NzExMzk2MzI1NDkwNzE4.X3BeXw.xVNd5hLYeOqroc2UqYFGA2ad24A'],
                                          client_id: CONFIG['client_id'],
                                          prefix: prefixes,
                                          ignore_bots: true,
                                          num_shards: CONFIG['shards'],
                                          shard_id: ARGV[0].to_i,
                                          spaces_allowed: true,
                                          compress_mode: :stream)
require_relative 'lib/hq'
