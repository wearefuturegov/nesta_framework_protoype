step 'my assessment should have the correct contact details' do
  @assessment ||= Assessment.last
  @assessment.reload
  user = @assessment.user
  expect(user).to be_a(User)
  expect(user.name).to eq(@name)
  expect(user.email).to eq(@email)
  expect(user.organisation_type).to eq(@organisation_type)
  expect(user.position).to eq(@position)
  expect(user.location).to eq(@location)
end
