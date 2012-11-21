require 'array_types_validator'

class ArrayValidator < ActiveModel::EachValidator
  attr_reader :attrib

  def validate_each(record, attribute, value)
    @attrib = attribute
    record.errors[attribute] << "must be in: #{show_list}" unless contains? value
  end

  protected

  def contains? value
    return true if value.nil?
    raise ArgumentError, "#{attrib} must be an Array, was: #{value}" unless value.kind_of?(Array)
    (value - list).empty?
  end

  # also works with range
  def list
    only.to_a
  end

  def only
    options[:in] || options[:only]
  end

  def show_list
    list.join(", ")
  end
end