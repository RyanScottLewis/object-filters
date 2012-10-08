require 'spec_helper'

describe Filters do
  
  let(:dummy_class) { Class.new { include(subject) } }
  
  describe 'ClassMethods' do
    subject { dummy_class }
    
    describe '.some_class_method' do
      it { should respond_to(:some_class_method) }
    end
    
  end
  
  describe 'InstanceMethods' do
    subject { dummy_class.new }
    
    describe '#some_instance_method' do
      it { should respond_to(:some_instance_method) }
    end
    
  end
  
end
