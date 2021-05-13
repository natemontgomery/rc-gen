require 'fox16'
require_relative './rc_name_gen.rb'
require_relative './pos_categories'
require 'pry'

include Fox

class RcNameGenerator < FXMainWindow
  include Responder

  def initialize(app)
    super(app, "RC Name Generator", opts: DECOR_ALL, width: 400, height: 400)

    window = FXPacker.new(self, opts: LAYOUT_FILL)

    add_word_count_submit(window)
  end

  def generate_name(pos_options)
    RcNameGen.new(pos_options).print_name
  end

  private

  def add_word_count_submit(packer)
    word_count_box = FXGroupBox.new(packer, nil, opts: FRAME_RIDGE|LAYOUT_FILL_X)
    word_count_frame = FXHorizontalFrame.new(word_count_box)

    pos_frame = FXVerticalFrame.new(packer, opts: LAYOUT_FILL|FRAME_SUNKEN)

    word_count_label = FXLabel.new(word_count_frame, "Number of words in name:")
    word_count_field = FXTextField.new(word_count_frame, 4)
    submit_count_button = FXButton.new(word_count_frame, "Submit")

    submit_count_button.connect(SEL_COMMAND) do
      word_count = [2, word_count_field.text.to_i].max
      word_count.times do |word_num|
        add_pos_chooser(pos_frame, word_num)
        packer.show
      end
    end
  end

  def add_pos_chooser(frame, word_num)
    pos_dialog = FXDialogBox.new(self, "Preferences", :padding => 2)
    button_frame = FXHorizontalFrame.new(pos_dialog, opts: PACK_UNIFORM_WIDTH)
    noun_button = FXButton.new(button_frame, "Noun")
    adjective_button = FXButton.new(button_frame, "Adjective")
    verb_button = FXButton.new(button_frame, "Verb")

    noun_button.connect(SEL_COMMAND) do
      puts 'foo'
    end

    adjective_button.connect(SEL_COMMAND) do
      puts 'foo'
    end

    verb_button.connect(SEL_COMMAND) do
      puts 'foo'
    end

    button_frame.show
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    RcNameGenerator.new(app)
    app.create
    app.run
  end
end
