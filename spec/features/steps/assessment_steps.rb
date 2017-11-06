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

step 'my assessment should have :num strong skills' do |num|
  @assessment.reload
  expect(@assessment.strong_skills.count).to eq(num.to_i)
end
