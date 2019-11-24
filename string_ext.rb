class String
  def titleize
    dup.gsub("::", "/").
      gsub(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2').
      gsub(/([a-z\d])([A-Z])/, '\1_\2').
      downcase.
      sub(/\A_+/, "").
      sub(/\A[\w-]/) { |match| match.upcase }.
      gsub(/\b(?<![\w-]['’`])[a-z]/) do |match|
        match.capitalize
      end
  end
end
