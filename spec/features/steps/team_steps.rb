step 'a team should be created with those team members' do
  expect(Team.count).to eq(1)
  team = Team.last
  expect(team.users.count).to eq(@team_members.count + 1)
  expect(team.users.first.email).to eq(@user.email)
  @team_members.each_with_index do |email, i|
    expect(team.users[i + 1].email).to eq(email)
  end
end
