require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/complete_me'
require 'csv'

class CompleteMeTest < Minitest::Test

  def test_it_exists
    skip
    complete_me = CompleteMe.new
    assert_instance_of CompleteMe, complete_me
  end

  def test_it_inserts_word
    skip
    complete_me = CompleteMe.new
    complete_me.insert("you")
    complete_me.insert("yum")
  end

  def test_it_suggests_words
    skip
    complete_me = CompleteMe.new
    complete_me.insert("pizza")
    words = complete_me.suggest("piz")
    assert_equal ["pizza"], words
  end

  def test_it_suggests_words
    skip
    complete_me = CompleteMe.new
    complete_me.insert("pizza")
    complete_me.insert("pizzaria")
    complete_me.insert("dog")
    complete_me.insert("doggie")
    assert_equal ["pizza", "pizzaria"], complete_me.suggest("piz")
    assert_equal ["dog", "doggie"], complete_me.suggest("do")
  end

  def test_it_can_load_dictionary
    skip
    complete_me = CompleteMe.new
    complete_me.load_dictionary
    expected = ["pize", "pizza", "pizzle", "pizzeria", "pizzicato"]
    assert_equal expected, complete_me.suggest("piz")
  end

  def test_it_can_select_best_words
    complete_me = CompleteMe.new
    complete_me.load_dictionary
    complete_me.select("piz", "pizza")
    complete_me.select("piz", "pizza")
    complete_me.select("piz", "pizzeria")
    assert_equal "pizza", complete_me.suggest("piz")[0]
    assert_equal "pizzeria", complete_me.suggest("piz")[1]
  end

  def test_it_can_remove_words
    complete_me = CompleteMe.new
    complete_me.load_dictionary
    complete_me.remove("trying")
    expected = ["pize", "pizza", "pizzle", "pizzeria", "pizzicato"]
    assert_equal expected, complete_me.suggest("piz")
  end

  def test_it_can_load_denver_addresses
    skip
    complete_me = CompleteMe.new
    CSV.foreach("./addresses.csv") do |row|
      full_address = row[-1].downcase
      complete_me.insert(full_address)
    end
    expected = ["114 w 3rd ave", "114 w bayaud ave"]
    assert_equal expected, complete_me.suggest("114 w")
  end

end
