include ActionView::Helpers::TextHelper

namespace :assessment do
  task :build => :environment do
    t1 = Time.now
    BuildAssessment.perform
    t2 = Time.now
    
    message = """
      Created #{pluralize(Area.count, 'area')}, #{pluralize(Skill.count, 'skill')}
      and #{pluralize(Attitude.count, 'attitudes')} in #{t2 - t1} seconds
    """.gsub("\n", ' ').squeeze(' ')
    puts "\033[32m#{message}\033[0m"
  end
end
