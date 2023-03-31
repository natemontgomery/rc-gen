require 'pry'
require 'tty-prompt'
require_relative './rc_name_gen.rb'
require_relative './pos_categories'

prompt = TTY::Prompt.new
pos_options = prompt.collect do
  word_count = key(:word_count).ask("How many words should be in the RC's name?", default: 2, convert: :int)
  subject_chosen = 'No'
  word_count.times do |idx|
    word_num = (idx + 1).to_s

    key(:pos_options).values do
      selected_pos = key(:pos).select(
        "What part of speech would you like for word \##{word_num}?",
        PosCategories::GENERALIZED_LIST.map { |pos| pos.to_s.capitalize }
      )

      case selected_pos
      when "Noun"
        key(:inflection).select("Singular or Plural?", ['Singular', 'Plural'])
        unless subject_chosen == 'Yes'
          subject_chosen = key(:subject).select("Should this be the subject?", ['Yes', 'No'])
        end
      when "Verb"
        key(:mood).select(
          "Whats your mood?",
          ['Indicative', 'Imperative', 'Subjunctive'],
          default: 1
        )

        key(:tense).select("In what tense?", ['Past', 'Present', 'Future'], default: 2)
        key(:person).select("In what person?", ['First', 'Second', 'Third'], default: 3)

        key(:aspect).select(
          "Using what aspect?",
          ['Habitual', 'Perfect', 'Perfective', 'Progressive', 'Prospective'],
          default: 1
        )
      end
    end
  end
end

RcNameGen.new(**pos_options).print_name
