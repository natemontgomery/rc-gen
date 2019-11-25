module PosCategories
  GENERALIZED_LIST = [
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
  PREPOSITION = ["prep."].freeze

  ABBREVIATION = ["abbr.", "Abbr.", "Hon.", "Revd."].freeze
  INTERJECTION = ["int."].freeze
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
end
