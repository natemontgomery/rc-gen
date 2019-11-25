require 'dry/inflector'
require 'verbs'
require 'json'
require_relative './string_ext'

class RcNameGen
  attr_reader :words, :word_count, :combination

  def initialize(word_count:, pos_options:)
    @words = JSON.parse(File.read('parsed-dictionary'), symbolize_names: true)
    @word_count = word_count
    @combination = pos_options
  end

  def rc_name
    inflector = Dry::Inflector.new
    combination.map do |word_options|
      word = words[word_options[:pos].downcase.to_sym].sample

      case word_options[:inflection]
      when 'Singular'
        inflector.singularize(word)
      when 'Plural'
        inflector.pluralize(word)
      when 'Past'
        Verbs::Conjugator.conjugate(word, tense: :past)
      when 'Present'
        Verbs::Conjugator.conjugate(word, tense: :present)
      when 'Future'
        Verbs::Conjugator.conjugate(word, tense: :future)
      else
        word
      end
    end
  end

  def print_name
    puts "\nRC #{rc_name.join(' ').titleize}\n\n"
  end
end
