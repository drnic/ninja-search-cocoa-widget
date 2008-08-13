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
    filtered_list_view.length
  end
  
  def tableView_objectValueForTableColumn_row(tableView, tableColumn, row)
    return unless tableView == @resultTableView
    filtered_list_view[row]
  end

  def original_list
    @input_list ||= begin
      ["Quick Brown Fox",
        "QUICKBROWNFOX",
        "QuickBrownFox",
        "quick_brown_fox",
        "quick-brown-fox",
        "quickbrownfox"
      ]
    end
  end
  
  # derives filter type or regular expression from cmd line options
  # default: spaces
  def filter_type
    :hyphens
  end
  
  def filtered_list
    @filtered_list ||= FilteredList.new(original_list, filter_type)
  end
  
  def filtered_list_view
    return original_list unless @searchQuery && !@searchQuery.stringValue.nil?
    filtered_list.filter(@searchQuery.stringValue) # caches result for same filter str
  end
end