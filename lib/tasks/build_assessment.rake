include ActionView::Helpers::TextHelper

namespace :assessment do
  task :build => :environment do
    t1 = Time.now
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
    
    t2 = Time.now
    
    message = """
      Created #{pluralize(Area.count, 'area')}, #{pluralize(Skill.count, 'skill')}
      and #{pluralize(Attitude.count, 'attitudes')} in #{t2 - t1} seconds
    """.gsub("\n", ' ').squeeze(' ')
    puts "\033[32m#{message}\033[0m"
  end
end
