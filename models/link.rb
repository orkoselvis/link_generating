# frozen_string_literal: true

class Link < ActiveRecord::Base
  validates_presence_of :url
end
