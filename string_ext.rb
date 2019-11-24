class String
  def humanize(capitalize: true)
    result = self.to_s.dup

    result.sub!(/\A_+/, "")
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
    underscore.humanize.gsub(/\b(?<!\w['’`])[a-z]/) do |match|
      match.capitalize
    end
  end
end
