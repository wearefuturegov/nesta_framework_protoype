class BuildAssessment
  
  def self.perform
    yaml = YAML.load File.read(File.join Rails.root, 'config', 'assessment.yml')
    yaml['areas'].each do |a|
      area = Area.create(name: a['name'], description: a['description'])
      a['skills'].each do |s|
        Skill.create(name: s['name'], description: s['description'], area: area)
      end
    end
    
    yaml['attitudes'].each do |a|
      Attitude.create(name: a['name'], description: a['description'])
    end
  end
  
end
