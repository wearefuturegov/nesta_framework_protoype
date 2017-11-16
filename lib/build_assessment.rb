class BuildAssessment
  
  def self.perform
    yaml = YAML.load File.read(File.join Rails.root, 'config', 'assessment.yml')
    yaml['areas'].each do |a|
      area = Area.create(name: a['name'], description: a['description'])
      a['skills'].each do |s|
        skill = Skill.create(name: s['name'], description: s['description'], area: area)
        (s['behaviours'] || []).each do |b|
          skill.behaviours << Behaviour.create(description: b)
        end
        skill.save
      end
    end
    
    yaml['attitudes'].each do |a|
      Attitude.create(name: a['name'], description: a['description'])
    end
  end
  
end
