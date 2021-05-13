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
    choose_words
    build_phrasing
  end

  def choose_words
    combination.map do |word_options|
      pos = word_options[:pos].downcase.to_sym
      chosen_word = words[pos].sample

      word_options[:word] = if pos == :noun
        inflect_noun(chosen_word, word_options[:inflection])
      else
        chosen_word
      end
    end
  end

  def build_phrasing
    combination.map do |word_options|
      pos = word_options[:pos].downcase.to_sym
      word = word_options[:word]

      case pos
      when :noun
        # Remove subject from final word array to allow verb conjugation to work
        if word_options[:subject] && find_verb
          nil
        else
          word
        end
      when :verb
        conjugate_verb(word, word_options)
      else
        word
      end
    end.compact
  end

  def inflect_noun(noun, inflection)
    inflector = Dry::Inflector.new
    case inflection
    when 'Singular'
      inflector.singularize(noun)
    when 'Plural'
      inflector.pluralize(noun)
    else
      noun
    end
  end

  def conjugate_verb(verb, conjugation_options)
    verb.verb.conjugate(
      conjugation_options.merge(subject: find_subject).transform_values do |opt|
        opt.to_s.downcase.to_sym
      end
    )
  end

  def find_subject
    combination.detect do |subject_options|
      subject_options[:pos] == 'Noun' && subject_options[:subject]
    end.to_h[:word]
  end

  def find_verb
    combination.detect do |subject_options|
      subject_options[:pos] == 'Verb'
    end.to_h[:word]
  end

  def print_name
    puts "\nRC #{rc_name.join(' ').titleize}\n\n"
  end
end
