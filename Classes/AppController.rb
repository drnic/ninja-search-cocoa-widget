require "rubygems"
require "textmate_ish_list_filter"

class AppController < OSX::NSObject
  include OSX
  
  ib_outlets :resultTableView, :searchQuery

  ib_action :applyFilter do |sender|
    @resultTableView.reloadData
  end
  
  ib_action :selectItem do |sender|
    puts filter_list_view[sender.selectedRow]
    exit
  end
  
  # protocol methods for NSTableView
  def numberOfRowsInTableView(tableView)
    filter_list_view.length
  end
  
  def tableView_objectValueForTableColumn_row(tableView, tableColumn, row)
    return unless tableView == @resultTableView
    filter_list_view[row]
  end


  def original_list
    list_or_file_name = ENV['NINJA_DATA'] || STDIN.read
    if File.exists?(list_or_file_name)
      list_or_file_name = File.read(list_or_file_name)
    end
    @input_list = list_or_file_name.split("\n")
  end
  
  def filter_list
    @filter_list ||= TextmateIshListFilter::FilterList.new(original_list)
  end
  
  def filter_list_view
    return original_list unless @searchQuery && !@searchQuery.stringValue.nil?
    filter_list.query(@searchQuery.stringValue.to_s) # caches result for same filter str
  end
end