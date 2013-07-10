require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutModules < Neo::Koan
  module Nameable
    def set_name(new_name)
      @name = new_name
    end

    def here
      :in_module
    end
  end

  def test_cant_instantiate_modules
    assert_raise(NoMethodError) do
      Nameable.new      # Modules are not Class, so you can't do a new
    end
  end

  # ------------------------------------------------------------------

  class Dog
    include Nameable

    attr_reader :name

    def initialize
      @name = "Fido"
    end

    def bark
      "WOOF"
    end

    def here
      :in_object
    end
  end

  def test_normal_methods_are_available_in_the_object
    fido = Dog.new
    assert_equal "WOOF", fido.bark
  end

  def test_module_methods_are_also_available_in_the_object
    fido = Dog.new
    assert_nothing_raised(Exception) do
      fido.set_name("Rover")
    end
  end

  # Dog has default name of "Fido"
  # we can change this @name variable using methods from module
  # included inside Class  
  def test_module_methods_can_affect_instance_variables_in_the_object
    fido = Dog.new
    assert_equal "Fido", fido.name
    fido.set_name("Rover")
    assert_equal "Rover", fido.name
  end


  # Class takes precedence in methods, if both are present
  # in other words, the Class method overrides the module method
  def test_classes_can_override_module_methods
    fido = Dog.new
    assert_equal :in_object, fido.here
  end
end
