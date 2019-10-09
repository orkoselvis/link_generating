# frozen_string_literal: true

module Helpers
  module_function

  def random
    SecureRandom.alphanumeric(15)
  end
end
