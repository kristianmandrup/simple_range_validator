class RangeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "must be within: #{show_range}" unless within? value
  end

  protected

  def within? value
    raise ArgumentError, "Must be a Range, was: #{value}" unless value.kind_of?(Range)
    range.cover?(value.min) && range.cover?(value.max)
  end

  def range
    options[:within]
  end

  def show_range
    "#{range.min}-#{range.max}"
  end
end