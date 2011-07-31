require 'minitest/unit'

require File.dirname(__FILE__) + '/../lib/mooconfig.rb'

class MatchTest < MiniTest::Unit::TestCase

  HOST = 'localhost'
  PORT = 27017
  DB   = 'foo'

  FIXED = { 'a' => { "a1"=>1, "a2"=>"2" } , 'b' => false }

  def setup
    c =  Mongo::Connection.new( HOST, PORT ).db( DB ).collection( 'config' )
    c.update( { '_id' => 'default' }, { '_id' => 'default', 'c' => FIXED }, { :upsert => true } )    
  end

  def teardown
    Mongo::Connection.new( HOST, PORT ).db( DB ).collection( 'config' ).remove( {'_id' => 'foo'})
  end

  def test_get
    confie = MooConfig::Config.new( HOST, PORT, DB ).get

    assert( confie == FIXED, "get retrivied #{confie.inspect} when expected #{FIXED.inspect}" )
  end

  def test_set!
    confie = MooConfig::Config.new( HOST, PORT, DB )
    confie.set!( { 'b' => true} )
    assert( confie.get['b'], "failed to update 'b'=>false" )
  end

  def test_no_default
    confie = MooConfig::Config.new( HOST, PORT, DB )
    confie.set!( confie.get, 'foo' )

    assert( confie.get( 'foo') == confie.get,  "Failed in test_no_default either get or set!")
  end
  
  def test_observer        
    confie = MooConfig::Config.new( HOST, PORT, DB )
    obsr = TObserve::new confie
    confie.set!( confie.get, 'foo' )
    assert( obsr.touched && obsr.seen_id=='foo', "observer was not notified" )
  end
  
  class TObserve
    attr :touched, false
    attr :seen_id, "_"
    
    def initialize(conf)
      conf.add_observer self
    end
    def update( c_id, c_data )
      @touched = true
      @seen_id = 'foo'
    end
  end
  
end
