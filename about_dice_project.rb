require File.expand_path(File.dirname(__FILE__) + '/neo')

# Implement a DiceSet Class here:
#

=begin :: My original solution
class DiceSet
  attr_reader :values
  def roll(number_of_dice)
    @values = []
    1.upto(number_of_dice) { |i| @values << Random.new.rand(1..6)  }
    return @values
  end
end
=end 

=begin :: Alternate solution using .inject
class DiceSet
  attr_reader :values

  def roll(number_of_dice)
    @values = number_of_dice.times.inject([]) { |arr, i| arr << rand(1..6) }
  end
end
=end 

# clearest solution
class DiceSet
  attr_reader :values

  def roll(number_of_dice)
    # this works
    # @values = number_of_dice.times.map{rand(1..6)}

    # this also works, clearer to understand too
    @values = Array.new(number_of_dice){ rand(1..6) }

    # this one does not work, because all values are the same, 
    # not random because rand(1..6) is only executed once
    # and result is assigned to all index in the Array
    # solution above using {block code} is the correct one!
    # since rand(1..6) will be executed for each index in the array
    # @values = Array.new(number_of_dice, rand(1..6))   
  end
end


class AboutDiceProject < Neo::Koan
  def test_can_create_a_dice_set
    dice = DiceSet.new
    assert_not_nil dice
  end

  def test_rolling_the_dice_returns_a_set_of_integers_between_1_and_6
    dice = DiceSet.new

    dice.roll(5)
    assert dice.values.is_a?(Array), "should be an array"
    assert_equal 5, dice.values.size
    dice.values.each do |value|
      assert value >= 1 && value <= 6, "value #{value} must be between 1 and 6"
    end
  end

  def test_dice_values_do_not_change_unless_explicitly_rolled
    dice = DiceSet.new
    dice.roll(5)
    first_time = dice.values
    second_time = dice.values
    assert_equal first_time, second_time
  end

  def test_dice_values_should_change_between_rolls
    dice = DiceSet.new

    dice.roll(5)
    first_time = dice.values

    dice.roll(5)
    second_time = dice.values

    assert_not_equal first_time, second_time,
      "Two rolls should not be equal"

    # THINK ABOUT IT:
    #
    # If the rolls are random, then it is possible (although not
    # likely) that two consecutive rolls are equal.  What would be a
    # better way to test this.
  end

  def test_you_can_roll_different_numbers_of_dice
    dice = DiceSet.new

    dice.roll(3)
    assert_equal 3, dice.values.size

    dice.roll(1)
    assert_equal 1, dice.values.size
  end

end
