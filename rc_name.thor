require 'thor'
require_relative './rc_name_gen.rb'

class RcName < Thor
  desc 'normal_mode', 'Make me something that probably makes sense'
  def normal_mode
    RcNameGen.new(mode: :normal).print_name
  end

  desc 'wild_mode', 'Make me somethign wild'
  def wild_mode
    RcNameGen.new(mode: :wild).print_name
  end
end
