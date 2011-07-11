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

    Mongo::Connection.new( HOST, PORT ).db( DB ).collection( 'config' ).remove( {'_id' => 'foo'})
  end

end
