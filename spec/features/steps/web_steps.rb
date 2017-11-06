step 'I access the new assessment page' do
  visit new_assessment_path
end

step 'I access the edit assessment page' do
  visit edit_assessment_path(@assessment)
end

step 'I click next' do
  click_button 'next'
end

step 'I choose :num :things' do |i, things|
  i.to_i.times do |i|
    card = all('.card_sort_single')[i]
    scroll_to(card).click
  end
  first(:button, I18n.t('buttons.next')).click
end

step 'I should be shown the ":type" form' do |type|
  text = case type
  when 'weak skills'
    ActionView::Base.full_sanitizer.sanitize I18n.t('assess.step_4.about')
  when 'strong attitudes'
    ActionView::Base.full_sanitizer.sanitize I18n.t('assess.step_5.about_1')
  when 'weak attitudes'
    ActionView::Base.full_sanitizer.sanitize I18n.t('assess.step_6.about')
  end
  expect(page.find('body').text).to match /#{text}/
end

step 'I should be shown my results' do
  expect(page.body).to match /COMING SOON/
end
