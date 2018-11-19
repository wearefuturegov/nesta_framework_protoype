require 'csv'

namespace :users do
  task :export => :environment do
    include Rails.application.routes.url_helpers
    
    s3 = Aws::S3::Resource.new(region: 'eu-west-2')
    bucket = s3.bucket('skills-and-innovation')
    
    file = CSV.generate do |csv|
      csv << ['Date Created', 'Email', 'Assessment Link']
      User.all.each do |u|
        next if u.assessment.nil?
        csv << [u.assessment.created_at.to_s(:short), u.email, assessment_url(u.assessment, host: 'skills-and-innovation.herokuapp.com')]
      end
    end
    
    object = bucket.put_object(body: file, acl: 'authenticated-read', key: "export-#{DateTime.now.to_s}.csv")
    
    puts 'File created! You can download it at the url below:'
    puts object.presigned_url(:get, expires_in: 3600)
  end
end
