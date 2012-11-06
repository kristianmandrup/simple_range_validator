class ArrayTypesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "must contain instances of only: #{show_allowed_types}, was: #{types_for(value)}" unless allowed_type? value
  end

  protected

  def allowed_type? value
    raise ArgumentError, "Must be an Array, was: #{value}" unless value.kind_of?(Array)
    return true if !allowed_types || allowed_types.empty?
    (types_for(value) - allowed_types).empty?
  end

  def types_for value
    value.map(&:class).uniq
  end

  def show_allowed_types
    allowed_types.join(", ")
  end

  def allowed_types
    [only].flatten
  end

  def only
    options[:only] || options[:in]
  end
end