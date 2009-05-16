#
#  rb_main.rb
#  NinjaSearch
#
#  Created by Dr Nic on 8/08/08.
#  Copyright (c) 2008 Dr Nic Academy Pty Ltd. All rights reserved.
#

require 'osx/cocoa'
require 'rubygems'

def rb_main_init
  path = OSX::NSBundle.mainBundle.resourcePath.fileSystemRepresentation
  rbfiles = Dir.entries(path).select {|x| /\.rb\z/ =~ x}
  rbfiles -= [ File.basename(__FILE__) ]
  rbfiles.each do |path|
    require( File.basename(path) )
  end
end

if $0 == __FILE__ then
  rb_main_init
  OSX.NSApplicationMain(0, nil)
end
