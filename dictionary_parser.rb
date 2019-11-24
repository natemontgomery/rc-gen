require 'pry'

dictionary = File.read('/Users/nathan/misc/rc-gen/shortened-oxford-dictionary')
words = dictionary.split("\n")
annotated_words = words.each_with_object({}) do |defined_word, memo|
  # defined_word.match(/^(?<word>.+) (?<pos>.+)[\. ]{1}(?<definition>.+)$/).named_captures
  descriptors = defined_word.split(' ')
  word = descriptors[0]
  pos = descriptors[1].gsub(/^-(.+)/, "$1")
  memo[pos] ||= []
  memo[pos] << word
  # binding.pry
end
binding.pry
words
