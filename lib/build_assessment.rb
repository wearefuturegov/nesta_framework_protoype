class BuildAssessment
  
  def self.perform
    yaml = YAML.load File.read(File.join Rails.root, 'config', 'assessment.yml')
    yaml['areas'].each do |a|
      area = Area.find_or_create_by(name: a['name'])
      area.description = a['description']
      area.colour = a['colour']
      area.save
      a['skills'].each do |s|
        skill = Skill.find_or_create_by(name: s['name'], area: area)
        skill.description = s['description']
        skill.behaviours = []
        (s['behaviours'] || []).each do |b|
          skill.behaviours << Behaviour.find_or_create_by(description: b)
        end
        skill.save
      end
    end
    
    yaml['attitudes'].each do |a|
      attitude = Attitude.find_or_create_by(name: a['name'])
      attitude.description = a['description']
      attitude.save
    end
  end
  
end
