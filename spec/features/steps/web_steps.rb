module WebSteps
  step :enter_details, 'I enter my details'
  step :click_next, 'I click next'
  step :click_back, 'I click the back button'

  step 'I access the new assessment page' do
    visit new_assessment_path
  end

  step 'I access the edit assessment page' do
    visit edit_assessment_path(@assessment)
  end

  step 'I choose :num :things' do |i, things|
    i.to_i.times do |i|
      card = all('.card_sort_single')[i]
      scroll_to(card).click
    end
    click_next
  end

  step 'I should be shown the ":type" form' do |type|
    template = type.parameterize(separator: '_')
    key = "assessments.#{template}.about_html"
    text = ActionView::Base.full_sanitizer.sanitize I18n.t(key)
    expect(page.find('body').text).to match /#{text.split.join(' ')}/
  end

  step 'I should be shown my results' do
    text = ActionView::Base.full_sanitizer.sanitize I18n.t('assessments.user.about_html')
    expect(page.body).to match /text/
  end

  step 'I select some skills' do
    @cards = select_cards(['Building Bridges', 'Brokering', 'Intrapreneurship', 'Future Acumen', 'Tech Literacy'])
  end
  
  step 'I select some attitudes' do
    @cards = select_cards(['Agile', 'Curious', 'Reflective'])
  end

  step 'I should not see those cards on the next screen' do
    @cards.each do |s|
      expect(page.body).to_not match /#{s}/
    end
  end

  step 'I have filled in my assessment' do
    visit new_assessment_path
    scroll_to(first :button, I18n.t('buttons.next')).click
    @strong_skills = select_cards(['Building Bridges', 'Brokering', 'Intrapreneurship', 'Future Acumen', 'Tech Literacy'])
    @weak_skills = select_cards(['Creative Facilitation', 'Political & Bureaucratic Awareness'])
    @strong_attitudes = select_cards(['Agile', 'Curious', 'Reflective'])
    @weak_attitudes = select_cards(['Empathetic'])
    enter_details
  end
  
  step 'I should see my results' do
    match_results(@strong_skills, '#strong_skills')
    match_results(@weak_skills, '#weak_skills')
    match_results(@strong_attitudes, '#strong_attitudes')
    match_results(@weak_attitudes, '#weak_attitudes')
  end
  
  def enter_details
    @name = 'Me'
    @email = 'me@example.com'
    @organisation_type ='Federal Government'
    @position = 'Management'
    @location = 'GB'
      
    fill_in 'assessment_user_attributes_name', with: @name
    fill_in 'assessment_user_attributes_email', with: @email
      
    select @organisation_type, from: 'assessment_user_attributes_organisation_type'
    select @position, from: 'assessment_user_attributes_position'
    
    first("option[value='#{@location}']").click

    click_next
  end
  
  def match_results(skills_or_attitudes, selector)
    skills_or_attitudes.each do |s|
      expect(page.find(selector).text).to match /#{s}/
    end
  end

  def select_cards(cards)
    cards.each do |label|
      card = first(:label, label)
      scroll_to(card).click
    end
    click_next
    cards
  end
  
  def click_next
    first(:button, I18n.t('buttons.next')).click
  end
  
  def click_back
    scroll_to(first :button, I18n.t('buttons.back')).click
  end
  
end

RSpec.configure do |config|
  config.include WebSteps, type: :feature
end
