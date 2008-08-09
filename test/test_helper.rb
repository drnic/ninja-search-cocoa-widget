require "test/unit"
require "osx/cocoa"

$:.unshift File.dirname(__FILE__) + "/../build/bundles"
$:.unshift File.dirname(__FILE__) + "/../Classes"

require "rubygems"
gem "Shoulda"
require "Shoulda"
# gem "mocha"
# require "mocha"

Context = Thoughtbot::Shoulda::Context