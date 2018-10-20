require 'pry'

class CompleteMe
  attr_reader :count

  def initialize
    @node = {}
    @count = 0
  end

  def insert(word)
    @count += 1
    node = @node
    word_length = word.length
    current_letter = 0
    word.chars.each do |letter|
      current_letter += 1
      x = letter.to_sym
      if node.has_key?(x)
        node = node[x]
      else
        if current_letter == word_length
          node[x] = {:end=>nil}
        else
          node[x] = {}
        end
        node = node[x]
      end
    end
    @count
  end

  def find_possibilities(node, word)
    word.chars.each do |letter|
      x = letter.to_sym
      if node.has_key?(x)
        node = node[x]
      else
        return "Error: no suggestions"
      end
    end
    node
  end

  def find_all_possibilities(possible_words)
    temp_words = []
    final_words = []
    possible_words.each do |w, n|
      n.keys.each do |key|
        if n[key] != nil && n[key].has_key?(:end)
          final_words << w + key.to_s
        end
        temp_words << [w + key.to_s, n[key]] unless key == :end
      end
    end
    [temp_words, final_words]
  end

  def suggest(word)
    node = @node
    node = find_possibilities(@node, word)
    final_words = []
    possible_words = [[word, node]]
    until possible_words.empty?
      found_words = find_all_possibilities(possible_words)
      possible_words = found_words[0]
      final_words = final_words << found_words[1]
    end
    final_words.flatten
  end

  def populate(dictionary)
    dictionary_words = dictionary.split("\n")
    dictionary_words.each do |word|
      insert(word.downcase)
    end
    nil
  end

  def load_dictionary
    dictionary = File.read("/usr/share/dict/words")
    populate(dictionary)
    nil
  end

end
