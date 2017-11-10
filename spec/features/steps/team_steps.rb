step 'a team should be created with those team members' do
  expect(Team.count).to eq(1)
  team = Team.last
  expect(team.users.count).to eq(@team_members.count + 1)
  expect(team.users.first.email).to eq(@user.email)
  @team_members.each_with_index do |email, i|
    expect(team.users[i + 1].email).to eq(email)
  end
end

step 'my team have completed all their assessments' do
  @users = []
  @users << FactoryBot.create(:user,
    email: 'me@example.com',
    name: 'Me',
    assessment: FactoryBot.create(:assessment,
      strong_skills: Skill.all.sample(5),
      weak_skills: Skill.all.sample(3),
      strong_attitudes: Skill.all.sample(3),
      weak_attitudes: Skill.all.sample(1),
    )
  )
  @users << FactoryBot.create(:user,
    email: 'someone@example.com',
    name: 'Someone Else',
    assessment: FactoryBot.create(:assessment,
      strong_skills: Skill.all.sample(5),
      weak_skills: Skill.all.sample(3),
      strong_attitudes: Skill.all.sample(3),
      weak_attitudes: Skill.all.sample(1),
    )
  )
  @users << FactoryBot.create(:user,
    email: 'anyone@example.com',
    name: 'Anyone',
    assessment: FactoryBot.create(:assessment,
      strong_skills: Skill.all.sample(5),
      weak_skills: Skill.all.sample(3),
      strong_attitudes: Skill.all.sample(3),
      weak_attitudes: Skill.all.sample(1),
    )
  )
  @team = FactoryBot.create(:team, users: @users)
end

step 'each team member should get an email' do
  @team_members.each_with_index do |email, i|
    expect(unread_emails_for(email).size).to eq(1)
    expect(unread_emails_for(email)[0]).to have_subject(I18n.t('user_mailer.assessment_invite.subject'))
  end
end
