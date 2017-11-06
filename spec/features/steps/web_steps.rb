step 'I access the new assessment page' do
  visit new_assessment_path
end

step 'I access the edit assessment page' do
  visit edit_assessment_path(@assessment)
end

step 'I click next' do
  click_button 'next'
end

step 'I choose :num skills' do |i|
  i.to_i.times do |i|
    card = all('.card_sort_single')[i]
    scroll_to(card).click
  end
  first(:button, 'next').click
end

step 'I should be shown the weak skills form' do
  expect(page.body).to match /least strong/
end

step 'I should be shown the ":type" form' do |type|
  case type
  when 'weak skills'
    expect(page.body).to match /least strong/
  when 'strong attitudes'
    expect(page.body).to match /attributes that you think your colleagues/
  end
end
