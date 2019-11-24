require 'pry'
require 'tty-prompt'
require_relative './rc_name_gen.rb'

MODES = [:normal, :wild]

prompt = TTY::Prompt.new

word_count = prompt.ask("How many words should be in the RC's name?", default: 2, convert: :int)
pos_choices = prompt.collect do
  word_count.times do |idx|
    word_num = (idx + 1).to_s
    key(word_num.to_sym).select(
      "What part of speech would you like for word \##{word_num}?",
      RcNameGen::PARTS_OF_SPEECH.map { |pos| pos.to_s.capitalize }
    )
  end
end

RcNameGen.new(word_count: word_count, pos_list: pos_choices.values).print_name
