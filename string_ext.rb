class String
  def humanize(capitalize: true)
    result = to_s.dup.sub(/\A_+/, "").tr("_", " ")

    if capitalize
      result.sub!(/\A\w/) { |match| match.upcase }
    end

    result
  end

  def underscore
    gsub("::", "/").
      gsub(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2').
      gsub(/([a-z\d])([A-Z])/, '\1_\2').
      tr("-", "_").
      downcase
  end

  def titleize(keep_id_suffix: false)
    underscore.humanize.gsub(/\b(?<!\w['’`])[a-z]/) do |match|
      match.capitalize
    end
  end
end
