require File.dirname(__FILE__) + "/test_helper"
require "FilteredList"

class Context
  def should_have_result_items(items)
    should "have result items #{items.inspect}" do
      assert_equal(items, results)
    end
  end
end

class TestFilteredList < Test::Unit::TestCase
  attr_reader :list, :filtered_list, :results
  context "For a list" do
    setup do
      @list = ["Quick Brown Fox",
        "QuickBrownFox",
        "quick_brown_fox",
        "quick-brown-fox",
        "quickbrownfox"
        ]
    end

    context "filtered by spaces" do
      setup { @filtered_list = FilteredList.new(@list, :spaces) }
      
      context "and search 'Q'" do
        setup { @results = filtered_list.filter('Q') }
        should_have_result_items ['Quick Brown Fox', 'QuickBrownFox']
      end
      
      context "and search 'QB'" do
        setup { @results = filtered_list.filter('QB') }
        should_have_result_items ['Quick Brown Fox']
      end
      
      context "and search 'QuBFo'" do
        setup { @results = filtered_list.filter('QuBFo') }
        should_have_result_items ['Quick Brown Fox']
      end
    end
    
  end
  
  context "Breakup filter string into partials" do
    setup do
      @filtered_list = FilteredList.new("", :spaces)
      @partials = filtered_list.send(:prepare_filter_string_for_search, "abcd")
    end

    should "break it up into testable parts" do
      expected = [
        ['abcd'],
        ['abc', 'd'],
        ['ab', 'c', 'd'],
        ['ab', 'cd'],
        ['a', 'b', 'cd'],
        ['a', 'b', 'c', 'd'],
        ['a', 'bc', 'd'],
        ['a', 'bcd']
        ]
      assert_equal(expected, @partials)
    end
  end
  
end