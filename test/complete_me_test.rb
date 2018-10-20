require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test

  def test_it_exists
    complete_me = CompleteMe.new
    assert_instance_of CompleteMe, complete_me
  end

  def test_it_inserts_word
    complete_me = CompleteMe.new
    complete_me.insert("you")
    complete_me.insert("yum")
  end

  def test_it_suggests_words
    complete_me = CompleteMe.new
    complete_me.insert("pizza")
    words = complete_me.suggest("piz")
    assert_equal ["pizza"], words
  end

  def test_it_suggests_words
    complete_me = CompleteMe.new
    complete_me.insert("pizza")
    complete_me.insert("pizzaria")
    complete_me.insert("dog")
    complete_me.insert("doggie")
    assert_equal ["pizza", "pizzaria"], complete_me.suggest("piz")
    assert_equal ["dog", "doggie"], complete_me.suggest("do")
  end

  def test_it_can_load_dictionary
    complete_me = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    complete_me.populate(dictionary)
    binding.pry
    expected = ["pize", "pizza", "pizzle", "pizzeria", "pizzicato"]
    assert_equal expected, complete_me.suggest("piz")
  end

end
