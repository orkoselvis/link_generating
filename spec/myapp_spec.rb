require 'spec_helper'
require 'capybara/rspec'

describe 'Myapp' do
  it 'should create new message' do
    visit '/'
    fill_in 'example', with: "Some message"
    click_button 'Go!' 
    expect(page).to have_text("Some message")
  end

  context 'message is deleted after some time' do
    it 'should destroy message after 3 hours' do
      visit '/'
      fill_in 'example', with: "Some new message"
      click_button 'Go!' 
      select 'hours', from: 'destruction_option'
      fill_in 'delete_value', with: '3'
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

  context 'message is deleted after one hour' do
    it 'should destroy message after one hour' do
      visit '/'
      fill_in 'example', with: "Some new message"
      click_button 'Go!' 
      click_button 'Delete after 1 hour!'
      Timecop.freeze(DateTime.now + 58.minutes) do
        visit current_path
        expect(page).to have_text("Some new message")
      end
      Timecop.freeze(DateTime.now + 10.minutes) do  
        visit current_path
        expect(page).to have_content 'Your message has been deleted within 1 hour!'
      end
    end  
  end
end