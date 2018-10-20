require './lib/complete_me'

complete_me = CompleteMe.new
complete_me.load_dictionary
text_data = ""

("a".."z").to_a.each do |letter|
  text_data += "#{letter}\t#{complete_me.suggest(letter).count}\n"
end

file_path = "./word_count.txt"
File.open(file_path, 'w') { |file| file.write(text_data) }
