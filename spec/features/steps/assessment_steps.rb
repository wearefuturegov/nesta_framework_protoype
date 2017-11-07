require 'build_assessment'

step 'the assessment data has been populated' do
  BuildAssessment.perform
end

step 'an assessment should exist' do
  expect(Assessment.count).to eq(1)
end

step 'I have started an assessment' do
  @assessment = FactoryBot.create(:assessment,
    strong_skills: [],
    weak_skills: [],
    strong_attitudes: [],
    weak_attitudes:[]
  )
end

step 'my assessment should have :num :type skills' do |num, type|
  @assessment.reload
  skills = type == 'strong' ? @assessment.strong_skills : @assessment.weak_skills
  expect(skills.count).to eq(num.to_i)
end

step 'my assessment should have :num :type attitude(s)' do |num, type|
  @assessment.reload
  attitudes = type == 'strong' ? @assessment.strong_attitudes : @assessment.weak_attitudes
  expect(attitudes.count).to eq(num.to_i)
end

step 'I have added my strong skills' do
  @assessment.update_column(:aasm_state, 'strong_skills_added')
end

step 'I have added my weak skills' do
  @assessment.update_column(:aasm_state, 'weak_skills_added')
end

step 'I have added my strong attitudes' do
  @assessment.update_column(:aasm_state, 'strong_attitudes_added')
end

step 'I have added my weak attitudes' do
  @assessment.update_column(:aasm_state, 'weak_attitudes_added')
end

step 'my assessment should have the correct contact details' do
  @assessment.reload
  user = @assessment.user
  expect(user).to be_a(User)
  expect(user.name).to eq(@name)
  expect(user.email).to eq(@email)
  expect(user.organisation_type).to eq(@organisation_type)
  expect(user.position).to eq(@position)
  expect(user.location).to eq(@location)
end
