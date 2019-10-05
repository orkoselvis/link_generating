require 'spec_helper'
require 'capybara/rspec'
require 'byebug'
require 'capybara-screenshot'

describe 'Myapp' do
  it 'should create new message' do
    visit '/'
    fill_in 'example', with: "New message"
    click_button 'Go!' 
    expect(page).to have_text("Some message")
  end

  context 'message is deleted after some time' do
    hours = 3
    
    before do
      visit '/'
      fill_in 'example', with: "Some new message"
      click_button 'Go!'  
    end

    it 'should delete message immediately' do
      visit current_path
      click_button 'Delete now!'
      expect(page).to have_text("Your message was deleted!")
    end

    it 'should destroy message after n-hours' do
      visit current_path
      find("#delete_value").set(hours)
      click_button 'Delete after n-hours!'
      Timecop.freeze(DateTime.now + 179.minutes) do
        visit current_path
        expect(page).to have_text("Some new message")
      end
      Timecop.freeze(DateTime.now + 1.hour) do  
        visit current_path
        expect(page).to have_content 'Your message has been deleted within 3 hours!'
      end
    end 
  end

end