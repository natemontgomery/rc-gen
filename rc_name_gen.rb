require 'pry'

class RcNameGen
  NOUN_GROUPS = ["DT", "NN", "NNS", "NNP", "NNPS", "POS"].freeze
  PRONOUN_GROUPS = ["PRP", "PRP$"].freeze
  ADJECTIVE_GROUPS = ["JJ", "JJR", "JJS"].freeze
  VERB_GROUPS = ["VB", "VBD", "VBG", "VBN", "VBP", "VBZ"].freeze
  ADVERB_GROUPS = ["RB", "RBR", "RBS"].freeze
  PREPOSITION_GROUPS = ["IN", "MD", "PDT", "UH", "TO"].freeze
  ASSIGNMENT_GROUPS = ["WDT", "WP", "WP", "WRB"].freeze
  MISC_GROUPS = ["CC", "CD", "EX", "FW", "LS", "RP"].freeze

  attr_reader :combination

  def initialize(mode:)
    @combination = case mode
    when :normal
      [ADJECTIVE_GROUPS.sample, NOUN_GROUPS.sample]
    else
      [
        [NOUN_GROUPS, PRONOUN_GROUPS, ADJECTIVE_GROUPS, VERB_GROUPS, ADVERB_GROUPS, PREPOSITION_GROUPS, ASSIGNMENT_GROUPS].sample.sample,
        [NOUN_GROUPS, PRONOUN_GROUPS, ADJECTIVE_GROUPS, VERB_GROUPS, ADVERB_GROUPS, PREPOSITION_GROUPS, ASSIGNMENT_GROUPS].sample.sample
      ]
    end
  end

  def annotated_words
    File.read('/Users/nathan/misc/rc-gen/words-annotated').split(' ')
  end

  def words_hash
    annotated_words.each_with_object({}) do |annotated_word, memo|
      word, part_of_speech = annotated_word.split('/')
      memo[part_of_speech] ||= []
      memo[part_of_speech] << word
    end
  end

  def print_name
    puts "\nRC #{words_hash[combination.first].sample.capitalize} #{words_hash[combination.last].sample.capitalize}\n\n"
  end
end
