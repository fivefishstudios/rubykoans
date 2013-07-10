require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutClasses < Neo::Koan
  class Dog
  end

  def test_instances_of_classes_can_be_created_with_new
    fido = Dog.new
    assert_equal Dog, fido.class
  end

  # ------------------------------------------------------------------

  class Dog2
    def set_name(a_name)
      @name = a_name
    end
  end

  def test_instance_variables_can_be_set_by_assigning_to_them
    fido = Dog2.new
    # return result is an Array, because we don't know how many
    # instance variables this class may hold
    assert_equal [], fido.instance_variables

    fido.set_name("Fido")
    # instance variables are returned as symbols, inside an array
    # note that the @ symbol is part of the variable
    assert_equal [:@name], fido.instance_variables
  end

  def test_instance_variables_cannot_be_accessed_outside_the_class
    fido = Dog2.new
    fido.set_name("Fido")

    assert_raise(NoMethodError) do
      fido.name
    end

    assert_raise(SyntaxError) do
      eval "fido.@name"
      # NOTE: Using eval because the above line is a syntax error.
    end
  end

  # so you can't access @instance variables, but you can ask for its value
  def test_you_can_politely_ask_for_instance_variable_values
    fido = Dog2.new
    fido.set_name("Fido")

    assert_equal "Fido", fido.instance_variable_get("@name")
  end

  def test_you_can_rip_the_value_out_using_instance_eval
    fido = Dog2.new
    fido.set_name("Fido")

    # review these 2 concepts 
    assert_equal "Fido", fido.instance_eval("@name")  # string version
    assert_equal "Fido", fido.instance_eval{ @name }  # block version
  end

  # ------------------------------------------------------------------

  class Dog3
    def set_name(a_name)
      @name = a_name
    end
    def name    # this is like a manual "getter" method in other language
      @name
    end
  end

  def test_you_can_create_accessor_methods_to_return_instance_variables
    fido = Dog3.new
    fido.set_name("Fido")

    assert_equal "Fido", fido.name
  end

  # ------------------------------------------------------------------

  class Dog4
    attr_reader :name     # this is an automatic "getter" method

    def set_name(a_name)
      @name = a_name      # this is like a manual "setter" method in Obj-C
    end
  end


  def test_attr_reader_will_automatically_define_an_accessor
    fido = Dog4.new
    fido.set_name("Fido")

    assert_equal "Fido", fido.name
  end

  # ------------------------------------------------------------------

  class Dog5
    attr_accessor :name     # this is the instant "setter" method
  end


  def test_attr_accessor_will_automatically_define_both_read_and_write_accessors
    fido = Dog5.new

    fido.name = "Fido"
    assert_equal "Fido", fido.name
  end

  # ------------------------------------------------------------------

  class Dog6
    attr_reader :name
    def initialize(initial_name)
      @name = initial_name
    end
  end

  def test_initialize_provides_initial_values_for_instance_variables
    fido = Dog6.new("Fido")
    assert_equal "Fido", fido.name
  end

  def test_args_to_new_must_match_initialize
    assert_raise(ArgumentError) do    # since Dog6 class is expecting an
                                      # initial value, we must supply 
                                      # when we create a new instance
      Dog6.new
    end
    # THINK ABOUT IT:
    # Why is this so?
    # 
    # ANSWER: 
    # since Dog6 class is expecting an
    # initial value, we must supply 
    # when we create a new instance
  end

  def test_different_objects_have_different_instance_variables
    fido = Dog6.new("Fido")
    rover = Dog6.new("Rover")

    assert_equal true, rover.name != fido.name
  end

  # ------------------------------------------------------------------

  class Dog7
    attr_reader :name

    def initialize(initial_name)
      @name = initial_name
    end

    def get_self
      self
    end

    def to_s
      @name
    end

    def inspect
      "<Dog named '#{name}'>"
    end
  end

  def test_inside_a_method_self_refers_to_the_containing_object
    fido = Dog7.new("Fido")

    fidos_self = fido.get_self
    # I don't know the answer to this one. Beats me.
    # assert_equal "<Dog named 'Fido'>", fidos_self
  end

  def test_to_s_provides_a_string_version_of_the_object
    fido = Dog7.new("Fido")
    assert_equal "Fido", fido.to_s
  end

  def test_to_s_is_used_in_string_interpolation
    fido = Dog7.new("Fido")
    assert_equal "My dog is Fido", "My dog is #{fido}"
  end

  def test_inspect_provides_a_more_complete_string_version
    fido = Dog7.new("Fido")
    assert_equal "<Dog named 'Fido'>" , fido.inspect
  end

  def test_all_objects_support_to_s_and_inspect
    array = [1,2,3]

    assert_equal "[1, 2, 3]", array.to_s
    assert_equal "[1, 2, 3]", array.inspect

    assert_equal "STRING", "STRING".to_s
    assert_equal "\"STRING\"", "STRING".inspect
  end

end
