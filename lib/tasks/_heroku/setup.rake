namespace :heroku do
  task :setup do
    current_branch = `git branch | grep ^* | awk '{ print $2 }'`.strip
    APP_CONFIG = YAML.load_file("#{File.dirname(__FILE__)}/../../../config/app.yml")["production"]
    conf = {
     "EXCEPTION_NOTIFICATION_RECIPIENT" => APP_CONFIG["exception_notification_recipient"],
     "EXCEPTION_NOTIFICATION_SENDER" => APP_CONFIG["exception_notification_sender"],
     "HEROKU" => "true",
     "HOSTNAME" => APP_CONFIG["hostname"],
     "MAIL__SMTP__DOMAIN" => APP_CONFIG["mail"]["smtp"]["domain"],
     "MAIL__SMTP__ADDRESS" => APP_CONFIG["mail"]["smtp"]["address"],
     "MAIL__SMTP__PORT" => APP_CONFIG["mail"]["smtp"]["port"],
     "MAIL__ACCOUNT__PASSWORD" => APP_CONFIG["mail"]["account"]["password"],
     "MAIL__ACCOUNT__USER_NAME" => APP_CONFIG["mail"]["account"]["user_name"],
     "NAME" => APP_CONFIG["name"],
     "BUNDLE_WITHOUT" => "development:test",
     "STORAGE" => APP_CONFIG['storage'],
     "STORAGE__S3_ACCESS" => APP_CONFIG['storage']['s3_access'],
     "STORAGE__S3_SECRET" => APP_CONFIG['storage']['s3_secret'],
     "MAILCHIMP_KEY" => APP_CONFIG['mailchimp_key'],
     "PAYPAL__ACCOUNT" => APP_CONFIG['paypal']['account'],
     "LOGENTRIES" => APP_CONFIG['logentries']
    }

    puts "We're about to set the following conf vars on Heroku for '#{current_branch}' application:"
    puts "(This configuration was taken from config/app.yml in production env)\n\n"
    conf.sort.each{|k, v| puts "     #{k.ljust(35)} =>   #{v}"}

    puts "\nPress 'y' if you want to continue"
    chr = STDIN.gets.chomp
    exit 0 unless chr =~ /^(y|Y)$/

    `heroku config:add #{conf.map{|k,v| "#{k}=#{v}"}.join(" ")}`
    puts "Done."
  end
end
