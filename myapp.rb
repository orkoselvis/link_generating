# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'aes'
require 'sinatra'
require 'sinatra/base'
require 'securerandom'
require 'sinatra/activerecord'
require 'sinatra/helper'
require 'bundler/setup'
require 'logger'
require 'active_support'
require 'byebug'

#set :database, "sqlite3:project-name.sqlite3"

use Rack::Session::Cookie, key: 'rack.session',
                           path: '/',
                           secret: 'your_secret'

RAILS_ROOT = File.expand_path(__dir__)

Log = Logger.new(File.expand_path('log/app.log', __dir__))

# class Myapp < Sinatra::Base

VALUE = 39

get '/' do
  @links = Link.all
  erb :index
end

get '/new' do
  erb :new
end

post '/generate' do
  key = AES.key
  @link = Link.new(url: Helpers.random,
                   encrypted_key: key, message: AES.encrypt(params[:text], key))
  @link.save
  redirect to("/message/#{@link.url}")
end

get '/message/:url' do
  @link = Link.find_by(url: params[:url])
  erb :show
end

def notify_message(time=1, notify)
  sleep time.minutes
  notify.delete
  notify = "Your message has been deleted within #{time} minutes!"
end

get '/delete/:url' do
  @message = Link.find_by(url: params[:url])
  few_hours = params[:delete_value].to_i
  hidden_value = params[:one_hour_value].to_i
  return redirect to('/') if @message.nil?
  return notify_message(@message) if hidden_value == VALUE
  return notify_message(few_hours, @message) if few_hours > 1
  erb :delete
end

require './models/link.rb'

# end
