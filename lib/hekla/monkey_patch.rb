require "time"

module Enumerable
  def group_by
    return to_enum :group_by unless block_given?
    assoc = {}

    each do |element|
      key = yield(element)

      if assoc.has_key?(key)
        assoc[key] << element
      else
        assoc[key] = [element]
      end
    end

    assoc
  end
end

class Hash
  def split(*keys)
    new_hash = select { |k, v| keys.include?(k) }
    return new_hash, delete_if { |k, v| keys.include?(k) }
  end

  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    self
  end
end

class NilClass
  def blank?
    true
  end
end

class String
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end

class Time
  def rfc3339
    DateTime.parse(to_s).rfc3339
  end
end
