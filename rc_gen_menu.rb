require 'pry'
require 'tty-prompt'
require_relative './rc_name_gen.rb'
require_relative './pos_categories'

prompt = TTY::Prompt.new

pos_options = prompt.collect do
  word_count = key(:word_count).ask("How many words should be in the RC's name?", default: 2, convert: :int)
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
      when "Verb"
        key(:inflection).select("In what tense?", ['Past', 'Present', 'Future'])
      end
    end
  end
end

RcNameGen.new(pos_options).print_name
