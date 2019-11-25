require 'dry/inflector'
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
    combination.map do |pos_options|
      word = words[pos_options[:pos].downcase.to_sym].sample

      case pos_options[:inflection]
      when 'Singular'
        inflector.singularize(word)
      when 'Plural'
        inflector.pluralize(word)
      else
        word
      end
    end
  end

  def print_name
    puts "\nRC #{rc_name.join(' ').titleize}\n\n"
  end
end
