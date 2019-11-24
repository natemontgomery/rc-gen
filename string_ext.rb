class String
  def humanize(lower_case_and_underscored_word, capitalize: true, keep_id_suffix: false)
    result = lower_case_and_underscored_word.to_s.dup

    result.sub!(/\A_+/, "")
    unless keep_id_suffix
      result.sub!(/_id\z/, "")
    end
    result.tr!("_", " ")

    if capitalize
      result.sub!(/\A\w/) { |match| match.upcase }
    end

    result
  end

  def underscore
    return self unless /[A-Z-]|::/.match?(self)
    word = self.gsub("::", "/")
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end

  def titleize(keep_id_suffix: false)
    humanize(underscore, keep_id_suffix: keep_id_suffix).gsub(/\b(?<!\w['’`])[a-z]/) do |match|
      match.capitalize
    end
  end
end
