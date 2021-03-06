require 'array_validator'
require 'timespan_validator'

class RangeValidator < ActiveModel::EachValidator
  attr_reader :attrib

  def validate_each(record, attribute, value)
    @attrib = attribute
    record.errors[attribute] << "must be within: #{show_range}" unless within? value
  end

  protected

  def within? value
    return true if value.nil?
    raise ArgumentError, "#{attrib} must be a Range, was: #{value}" unless value.kind_of?(Range)
    range.cover?(value.min) && range.cover?(value.max)
  end

  def range
    options[:within]
  end

  def show_range
    "#{range.min}-#{range.max}"
  end
end