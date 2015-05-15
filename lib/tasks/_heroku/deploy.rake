namespace :heroku do
  desc "Deploy to production"
  task :deploy do
    Rake::Task['heroku:before_deploy'].invoke(:production, "production")
    Rake::Task['heroku:update_code'].invoke(:production, "production")
    Rake::Task['heroku:after_deploy'].invoke(:production, "production")
  end

  task :before_deploy, :env, :branch do |t, args|

  end

  task :after_deploy, :env, :branch do |t, args|
    `heroku run rake db:migrate`
    puts "Done rake db:migrate"
    puts "Deployment Complete"
  end

  task :update_code, :env, :branch do |t, args|
    FileUtils.cd Rails.root do
      `git push heroku master`
    end
  end
end
