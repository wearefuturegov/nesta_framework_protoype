module WebSteps
  step :enter_details, 'I enter my details'
  step :click_next, 'I click next'
  step :click_back, 'I click the back button'
  step :access_edit_assessment_page, 'I access the edit assessment page'
  step :complete_assessment, 'I fill out the assessment'
  step :create_assessment_from_user_link, 'I create an assessment from the user link'
  step :should_see_my_results, 'I should see my results'
  
  step 'I access the new assessment page' do
    visit new_assessment_path
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
  
  step 'my skills should be selected' do
    @assessment.strong_skills.each do |s|
      card = find('div', text: /\A#{s.name}\Z/).find(:xpath, '../..')
      expect(card[:class]).to include('selected')
      expect(card.find('input', visible: false)[:checked]).to eq('true')
    end
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
    complete_assessment
    enter_details
  end
  
  step 'I have used the back button to edit my strong skills' do
    access_edit_assessment_page
    select_strong_cards
    click_back
  end
  
  step 'I share the assessment with my team members' do
    @team_members = [
      'alice@example.com',
      'bob@example.com'
    ]
    visit share_assessment_path(@assessment)
    click_on I18n.t('assessments.share.add_team_member')
    @team_members.each do |email|
      all(:css, '.team_member').last.set(email)
      click_on I18n.t('assessments.share.add_team_member')
    end
    click_on I18n.t('buttons.submit')
  end
    
  step 'I should see my email address on the user form' do
    expect(find('#assessment_user_attributes_email')[:value]).to eq(@user.email)
  end
  
  step 'I have filled out an assessment from the user link' do
    create_assessment_from_user_link
    complete_assessment
  end
  
  step 'I access the team summary page' do
    visit team_assessments_path(@team)
  end
  
  step 'I should see all my team\'s assessment results' do
    @team.users.each_with_index do |user, i|
      div = all('.assessment')[i]
      @strong_skills = user.assessment.strong_skills.map { |s| s.name }
      @weak_skills = user.assessment.weak_skills.map { |s| s.name }
      @strong_attitudes = user.assessment.strong_attitudes.map { |a| a.name }
      @weak_attitudes = user.assessment.weak_attitudes.map { |a| a.name }
      should_see_my_results(div)
      expect(div.text).to match /#{user.name}/
    end
  end
  
  def should_see_my_results(container = nil)
    container ||= page
    match_results(@strong_skills, container, '#strong_skills')
    match_results(@weak_skills, container, '#weak_skills')
    match_results(@strong_attitudes, container, '#strong_attitudes')
    match_results(@weak_attitudes, container, '#weak_attitudes')
  end
  
  def create_assessment_from_user_link
    @user = FactoryBot.create(:user, :without_details)
    visit start_assessment_user_path(@user)
  end
  
  def complete_assessment
    @strong_skills = select_strong_cards
    @weak_skills = select_cards(['Creative Facilitation', 'Political & Bureaucratic Awareness'])
    @strong_attitudes = select_cards(['Agile', 'Curious', 'Reflective'])
    @weak_attitudes = select_cards(['Empathetic'])
  end
  
  def select_strong_cards
    select_cards(['Building Bridges', 'Brokering', 'Intrapreneurship', 'Future Acumen', 'Tech Literacy'])
  end
  
  def access_edit_assessment_page
    visit edit_assessment_path(@assessment)
  end
  
  def enter_details
    @name = 'Me'
    @email = @user.try(:email) || 'me@example.com'
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
  
  def match_results(skills_or_attitudes, container, selector)
    skills_or_attitudes.each do |s|
      expect(container.find(selector).text).to match /#{s}/
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
