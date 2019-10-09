# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'myapp'))
require 'delayed/command'
Delayed::Command.new(ARGV).daemonize
