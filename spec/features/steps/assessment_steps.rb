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

step 'I have added my strong skills' do
  @assessment.update_column(:aasm_state, 'strong_skills_added')
end
