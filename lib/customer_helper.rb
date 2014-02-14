module CustomerHelper
  def self.register_type(type)
    valid_type?(type) || types << normalize_type(type)
  end

  def self.valid_type?(type)
    types.include?(normalize_type(type))
  end

  def self.normalize_type(type)
    type.downcase.to_sym
  end

  private

  def self.types
    @types ||= []
  end
end
