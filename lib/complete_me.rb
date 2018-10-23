require 'pry'

class CompleteMe
  attr_reader :count

  def initialize
    @node = {}
    @count = 0
  end

  def remove(word)
    node = @node
    word.chars.each_with_index do |letter, i|
      x = letter.to_sym
      node = node[x]
      if (i + 1) == word.length
        node.delete(:end)
      end
    end
  end


  def insert(word, partial_word = false)
    @count += 1 unless partial_word
    node = @node
    word.chars.each_with_index do |letter, i|
      x = letter.to_sym
      if node.has_key?(x)
        node = node[x]
        if (i + 1) == word.length && partial_word
          node[:end] << partial_word
        end
      else
        if (i + 1) == word.length
          node[x] = {:end=>[]}
        else
          node[x] = {}
        end
        node = node[x]
      end
    end
    @count
  end

  def select(partial_word, word)
    insert(word, partial_word)
  end

  def find_possibilities(node, word)
    word.chars.each do |letter|
      x = letter.to_sym
      if node.has_key?(x)
        node = node[x]
      end
    end
    node
  end

  def find_all_possibilities(possible_words)
    temp_words = []
    final_words = []
    possible_words.each do |w, n|
      n.keys.each do |key|
        if n[key].class != Array && n[key].has_key?(:end)
          final_words << [w + key.to_s, n[key][:end]]
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
    cleanup_words(final_words, word)
  end

  def cleanup_words(final_words, word)
    final_words = final_words.reject { |a| a.empty? }.flatten(1)
    final_words.map! do |finals|
      [finals[1].count(word), finals[0]]
    end
    final_words.sort_by! { |finals| -finals[0] }
    final_words.map! { |finals| finals[1] }
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
  end

end
