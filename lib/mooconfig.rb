require 'mongo'
require 'observer'

module MooConfig

  class Config
    include Observable
    
    DEFAULT_CONFIG_ID = 'default'
    
    def initialize( host, port, db, conf_collection='config' )
      @cCollection   = Mongo::Connection.new( host, port ).db( db ).collection( conf_collection )
    rescue => err
      puts "Config::initialize something is wrong with mongo details [host:#{host}, port:#{port}, db:#{db}]"
      raise err
    end

    def get( config_id = DEFAULT_CONFIG_ID )
      @cCollection.find_one( { '_id' => config_id } )['c'] rescue {}
    end

    def set!( config, config_id = DEFAULT_CONFIG_ID )
      changed
      @cCollection.update( {'_id'=>config_id }, {'_id'=>config_id, 'c' => config }, { :upsert => true } )
      notify_observers( config_id , get( config_id )  )
    end
        
  end

end

