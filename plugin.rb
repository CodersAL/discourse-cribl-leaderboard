# name: discourse-cribl-leaderboard
# about: A plugin that grabs Cribl community leaderboard data from S3 Athena and presents it on Disocourse
# version: 0.2
# authors: Robert Barrow, Keegan George
# url: https://github.com/paviliondev/discourse-cribl-leaderboard

gem 'aws-sdk-athena', '1.42.0'
gem 'athens', '0.4.0'  # https://github.com/getletterpress/athens

enabled_site_setting :cribl_leaderboard_enabled
register_asset 'stylesheets/sass/cribl-leaderboard.scss'

if respond_to?(:register_svg_icon)
  register_svg_icon "long-arrow-alt-up"
  register_svg_icon "long-arrow-alt-down"
end

after_initialize do  
  %w[
    ../lib/cribl_leaderboard/engine.rb
    ../lib/cribl_leaderboard/athena_queries.rb
    ../app/controllers/leaderboard.rb
    ../config/routes.rb
  ].each do |key|
    load File.expand_path(key, __FILE__)
  end

  Athens.configure do |config|
    config.output_location = SiteSetting.cribl_leaderboard_s3_query_output_location # Required
    config.aws_access_key      = SiteSetting.s3_access_key_id
    config.aws_secret_key      = SiteSetting.s3_secret_access_key
    config.aws_region          = SiteSetting.s3_region
    config.wait_polling_period = 0.25 # Optional - What period should we poll for the complete query?
    config.result_encryption   = nil
  end
end
