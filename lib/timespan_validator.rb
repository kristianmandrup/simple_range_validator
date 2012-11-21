class TimespanValidator < ActiveModel::EachValidator
  attr_reader :attrib

  def validate_each(record, attribute, value)
    @attrib = attribute
    record.errors[attribute] << "must be within: #{show_range}" unless within? value
  end

  protected

  def within? value
    return true if value.nil?
    raise ArgumentError, "#{attrib} must be a Timespan, was: #{value}" unless value.kind_of?(Timespan)
    # puts "value: #{value} between? #{from} and #{to}"    
    value.between?(from, to)
  end

  def from
    options[:from]
  end

  def to
    options[:to]
  end

  def show_range
    "#{from} - #{to}"
  end
end