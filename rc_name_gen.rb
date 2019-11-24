require 'pry'

class RcNameGen
  PARTS_OF_SPEECH = [
    :noun,
    :pronoun,
    :adjective,
    :verb,
    :adverb,
    :preposition
  ].freeze

  NOUN = ["n.", "n.pl.", "pl.", "scot."].freeze
  PRONOUN = ["pron."].freeze
  VERB = ["v.", "v.aux.", "v.refl.", "pres.", "orig."].freeze
  ADVERB = ["adv.", "poss."].freeze

  ABBREVIATION = ["abbr.", "Abbr.", "Hon.", "Revd."].freeze
  INTERJECTION = ["int."].freeze
  PREPOSITION = ["prep."].freeze
  PREDICATE = ["predic."].freeze
  CONTRACTION = ["contr."].freeze
  CONJUNCTION = ["conj."].freeze

  ADJECTIVE = [
    "adj.",
    "gram.",
    "colloq.",
    "mus.",
    "attrib.",
    "compar.",
    "superl.",
    "geol.",
    "hist.",
    "usu.",
    "math.",
    "poet."
  ].freeze

  attr_reader :words, :word_count, :combination

  def initialize(word_count:, pos_list:)
    @words = words_hash
    @word_count = word_count
    @combination = pos_list
  end

  def annotated_words
    File.read('/Users/nathan/misc/rc-gen/shortened-oxford-dictionary').split("\n")
  end

  def words_hash
    granular_word_hash = annotated_words.each_with_object({}) do |defined_word, memo|
      descriptors = defined_word.split(' ')
      word = descriptors[0].to_s.gsub(/^.+\d.+/, '')
      pos = descriptors[1].to_s.gsub('—', '')
      next unless pos[-1] == '.' # all our PoS end in a period

      memo[pos] ||= []
      memo[pos] << word
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
      words[part_of_speech].sample.capitalize
    end
  end

  def print_name
    puts "\nRC #{rc_name.join(' ')}\n\n"
  end
end
