require 'open_nlp'

english_words = File.read('/Users/nathan/misc/rc-gen/words_alpha.txt')
pos_model = OpenNlp::Model::POSTagger.new(File.join("/Users/nathan/misc/rc-gen/en-pos-maxent.bin"))
pos_tagger = OpenNlp::POSTagger.new(pos_model)
result = pos_tagger.tag(english_words)

word_file = File.open('/Users/nathan/misc/rc-gen/words-annotated', 'w+')
word_file.write(result)
word_file.close
