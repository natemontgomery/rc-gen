require 'tty-prompt'
require 'json'
require_relative './pos_categories'

class DictionaryParser
  attr_reader :dictionary, :words

  def initialize(dictionary:)
    @dictionary = dictionary
    @words = words_hash
  end

  def output_parsed_dictionary
    File.open('parsed-dictionary', 'w+') do |file|
      file.write(words.to_json)
    end
  end

  def annotated_words
    File.read(dictionary).split("\n")
  end

  def words_hash
    granular_word_hash = annotated_words.each_with_object({}) do |defined_word, memo|
      raw_descriptors = defined_word.split('.')[0].to_s
      descriptors = raw_descriptors.split(' ')
      word = descriptors[0..-2].join('-').to_s.gsub(/\d$/, '')
      pos = descriptors[-1].to_s.gsub('—', '') << '.'

      memo[pos] ||= []
      memo[pos] << word
    end

    map_granular_pos(granular_word_hash)
  end

  def map_granular_pos(word_list)
    PosCategories::GENERALIZED_LIST.each_with_object({}) do |pos, memo|
      PosCategories.const_get(pos.to_s.upcase).each do |granular_pos|
        granular_word_list = word_list[granular_pos].to_a
        memo[pos] ||= []
        memo[pos] += granular_word_list
      end
    end
  end
end

prompt = TTY::Prompt.new
file_path = prompt.ask("Where is your dictionary file?")
DictionaryParser.new(dictionary: file_path).output_parsed_dictionary
