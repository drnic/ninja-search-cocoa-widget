#
#  ListItem.rb
#  NinjaSearch
#
#  Created by Dr Nic on 9/08/08.
#  Copyright (c) 2008 Dr Nic Academy Pty Ltd. All rights reserved.
#
class Array
  def replace_at(idx, replacement)
    self[0...idx] + [replacement] + self[idx+1...length]            
  end
  
  def pad(to_length, item='')
    return self if to_length <= self.length
    (self.clone << item).pad(to_length, item)
  end
end  

class FilteredList
  attr_reader :filter_type
  def initialize(list, filter_type)
    @unfiltered_list = list
    @filter_type     = filter_type
  end
  
  def filter(filter_str)
    filter_partials_list = prepare_filter_string_for_search(filter_str)
    @unfiltered_list.select do |item|
      partials = prepare_item_for_search(item)
      filter_partials_list.find do |filter_partials|
        next false if filter_partials.length > partials.length
        _filter_partials = filter_partials.pad(partials.length)
        [partials, _filter_partials].transpose.find do |partial, filter_partial|
          partial =~ /\b#{filter_partial}/i
        end
      end
    end
  end
  
  protected
  def prepare_item_for_search(item)
    case filter_type
    when :spaces
      item.split(/\s+/)
    when :capitalize
      item.split(/(?:[^A-Z])[A-Z]/)
    when :hyphens
      item.split('-')
    when :underscore
      item.split('_')
    else
      throw "Unknown filter type '#{filter_type}'"
    end
  end
  
  def prepare_filter_string_for_search(*strings)
    res = []
    strings.each_with_index do |str, idx|
      if str.length > 1
        (1..str.length-1).to_a.map {|i| [str[0...i], str[i...str.length]] }.each do |new_str|
          to_add = strings.replace_at(idx, new_str).flatten
          res.push(to_add, *prepare_filter_string_for_search(*to_add)) 
        end
      end  
    end
    (res << strings)
    res.uniq.reverse
  end
end

