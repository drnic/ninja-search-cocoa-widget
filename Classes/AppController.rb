require "rubygems"
require "textmate_ish_list_filter"

class AppController < OSX::NSObject
  include OSX
  
  ib_outlets :resultTableView, :searchQuery

  ib_action :applyFilter do |sender|
    @resultTableView.reloadData
  end
  
  ib_action :selectItem do |sender|
    NSLog("#{sender.selectedRow.inspect}")
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
    # TODO remove the defaults + only allow STDIN etc
    @input_list ||= %w[
      app/models/article.rb
      app/controllers/blog_controller.rb
      test/functionals/blog_controller_test.rb
      web/log/production.rb
    ]
  end
  
  def filter_list
    @filter_list ||= TextmateIshListFilter::FilterList.new(original_list)
  end
  
  def filter_list_view
    return original_list unless @searchQuery && !@searchQuery.stringValue.nil?
    filter_list.query(@searchQuery.stringValue.to_s) # caches result for same filter str
  end
end