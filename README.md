#The what?
Doing configuration with MongoDB

- - - 
#Install gem?
gem install mooconfig

#The how?

##Preliminaries
 MongoDB (http://www.mongodb.org/)
 See Gemfile for dependancies

##Usage
 host = 'localhost'; port = 21017; db='foo'

###Init
 mconf = MooConfig::Config.new( host, port, db )
###Set configuration
 mconf.set!( { "a" => true, "b" => { "b1" => "1", "b2" => 1234, "b3" => [ "z", 3, "e" ] }, "c" => "asdf" } ) # default config

 mconf.set!( { "a" => false, "b" => { "b1" => "1", "b2" => 1234, "b3" => [ "z", 3, "e" ] }, "c" => "asdf" }, "production" )

###Get configuration
 puts "production configuration: #{mconf.get( "production" )['a']} \n default configuration: #{mconf.get['a']}"


###Observers
 Register observers -- get notifications whenever set!(..) is performed

 	class MyConfigObserver
 		def initialize(conf)
   			conf.add_observer self # attach observer to the configuration
 		end
 		
		def update( c_id, c_data )
   			# .. get an update -- configuration id, and configuration data
 		end
	end			

##Test
 via guard and guardminitest
 see test folder

#License
##The MIT License
``
Copyright (c) 2010 ronbee.github@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.''
