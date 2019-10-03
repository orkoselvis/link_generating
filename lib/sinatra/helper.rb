
module Helpers
  extend self

  def random
    SecureRandom.alphanumeric(15) 
  end
  
end
