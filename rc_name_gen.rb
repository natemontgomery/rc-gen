require 'pry'

class RcNameGen
  PARTS_OF_SPEECH = [:noun, :pronoun, :adjective, :verb, :adverb, :preposition, :assignment]
  NOUN = ["DT", "NN", "NNS", "NNP", "NNPS", "POS"].freeze
  PRONOUN = ["PRP", "PRP$"].freeze
  ADJECTIVE = ["JJ", "JJR", "JJS"].freeze
  VERB = ["VB", "VBD", "VBG", "VBN", "VBP", "VBZ"].freeze
  ADVERB = ["RB", "RBR", "RBS"].freeze
  PREPOSITION = ["IN", "MD", "UH", "TO"].freeze
  ASSIGNMENT = ["WDT", "WP", "WP", "WRB"].freeze
  MISC = ["CC", "CD", "EX", "FW", "LS", "RP"].freeze

  attr_reader :words, :word_count, :combination

  def initialize(word_count:, pos_list:)
    @words = words_hash
    @word_count = word_count
    @combination = generate_pos_list
  end

  def generate_pos_list
    pos_list = []
    word_count.times do
      pos_list << PARTS_OF_SPEECH.sample
    end
    pos_list
  end

  def annotated_words
    File.read('/Users/nathan/misc/rc-gen/words-annotated').split(' ')
  end

  def words_hash
    granular_word_hash = annotated_words.each_with_object({}) do |annotated_word, memo|
      word, part_of_speech = annotated_word.split('/')
      memo[part_of_speech] ||= []
      memo[part_of_speech] << word
    end

    map_granular_pos(granular_word_hash)
  end

  def map_granular_pos(word_list)
    PARTS_OF_SPEECH.each_with_object({}) do |pos, memo|
      self.class.const_get(pos.to_s.upcase).each do |granular_pos|
        granular_word_list = word_list[granular_pos]
        memo[pos] ||= []
        memo[pos] += granular_word_list
      end
    end
  end

  def rc_name
    combination.map do |part_of_speech|
      words[combination.first].sample.capitalize
    end
  end

  def print_name
    puts "\nRC #{rc_name.join(' ')}\n\n"
  end
end
