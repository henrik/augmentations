require 'test/unit'
require File.join(File.dirname(__FILE__), '../init')

class ModelBase
  def self.belongs_to(x) @belongs_to = x end
  def self.has_one(x) @has_one = x end
end

module ModuleOne
  augmentation do    
     belongs_to :test
     def an_instance_method?() true end
     def self.belongs_to?(x) @belongs_to == x end
  end
end

module ModuleTwo
  augmentation do    
     has_one :test
     def another_instance_method?() true end
     def self.has_one?(x) @has_one == x end
  end
end

class MyModel < ModelBase
  augment ModuleOne, ModuleTwo
end


class AugmentationsTest < Test::Unit::TestCase
  
  def test_calling_and_defining_class_methods
    assert MyModel.belongs_to?(:test)
    assert MyModel.has_one?(:test)
  end
  
  def test_defining_instance_methods
    my_model = MyModel.new
    assert my_model.an_instance_method?
    assert my_model.another_instance_method?
  end

end
