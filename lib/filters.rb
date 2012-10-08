require 'pathname'
require 'bundler/setup'

__PATH__ = Pathname.new(__FILE__)
$:.unshift(__PATH__.dirname.to_s) unless $:.include?(__PATH__.dirname.to_s)

module Filters
  extend ActiveSupport::Concern
  
  module ClassMethods
    
    def some_class_method
      
    end
    
  end
  
  def some_instance_method
    
  end
  
end