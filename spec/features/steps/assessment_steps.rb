require 'build_assessment'

step 'the assessment data has been populated' do
  BuildAssessment.perform
end

step 'an assessment should exist' do
  expect(Assessment.count).to eq(1)
end
