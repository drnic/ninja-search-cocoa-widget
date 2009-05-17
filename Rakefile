require "rubygems"
require "rake"

require "choctop"

$choctop = ChocTop.new do |s|
  # Remote upload target (set host if not same as Info.plist['SUFeedURL'])
  # s.host     = 'ninjasearch.com'
  s.remote_dir = '/path/to/upload/root/of/app'

  # Custom DMG
  s.background_file = "background.png"
  s.app_icon_position = [100, 120]
  s.applications_icon_position =  [400, 120]
  s.volume_icon = "dmg.icns"
  # s.applications_icon = "appicon.icns" # or "appicon.png"
end


desc <<-DESC
Runs the widget with the file names from this project as a sample
  BUILD_TYPE: build type of widget to use (Default: Release; or Debug)
DESC
task :demo => [:build, :demo_no_build]

task :demo_no_build do
  require "fileutils"
  FileUtils.chdir(File.dirname(__FILE__)) do
    build_type = ENV['BUILD_TYPE'] || 'Debug'
    widget = "build/#{build_type}/#{$choctop.target}/Contents/MacOS/#{$choctop.name}"
    files = Dir["**/*"].map { |f| e_sh f }.join("\n").gsub("'",%q{\'})
    
    p res = %x{NINJA_DATA='#{files}' #{e_sh widget}  2>/dev/console}
    p canceled = ($? != 0)
  end
  
end

def e_sh(str)
	str.to_s.gsub(/(?=[^a-zA-Z0-9_.\/\-\x7F-\xFF\n])/, '\\').gsub(/\n/, "'\n'").sub(/^$/, "''")
end
