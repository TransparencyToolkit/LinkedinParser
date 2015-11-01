module Utilities
  # Check if item is nil or empty
  def is_empty?(item)
    item == nil || item.text.empty?
  end
end
