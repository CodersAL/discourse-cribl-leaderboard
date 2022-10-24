# name: discourse-cribl-leaderboard
# about: A plugin that grabs Cribl community leaderboard data from S3 Athena and presents it on Disocourse
# version: 0.4
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
    ../lib/cribl_leaderboard/postgres_queries.rb
    ../app/controllers/leaderboard.rb
    ../app/models/leaderboard_score.rb
    ../app/models/leaderboard_present_view.rb
    ../app/models/leaderboard_quarter_points_view.rb
    ../app/models/leaderboard_quarter_ranking_view.rb
    ../app/models/leaderboard_todays_points_view.rb
    ../app/models/leaderboard_todays_ranking_view.rb
    ../app/models/leaderboard_todays_ranking_with_move_view.rb
    ../app/models/leaderboard_total_ranking_view.rb
    ../app/models/leaderboard_yesterdays_points_view.rb
    ../app/models/leaderboard_yesterdays_ranking_view.rb
    ../config/routes.rb
  ].each do |key|
    load File.expand_path(key, __FILE__)
  end

  begin

    %w[
      ../postgres/tables/leaderboard_scores.sql
      ../postgres/views/leaderboard_present_view.sql
      ../postgres/views/leaderboard_quarter_points_view.sql
      ../postgres/views/leaderboard_todays_points_view.sql
      ../postgres/views/leaderboard_yesterdays_points_view.sql
      ../postgres/views/leaderboard_yesterdays_ranking_view.sql
      ../postgres/views/leaderboard_quarter_ranking_view.sql
      ../postgres/views/leaderboard_todays_ranking_view.sql
      ../postgres/views/leaderboard_todays_ranking_with_move_view.sql
      ../postgres/views/leaderboard_total_ranking_view.sql
    ].each do |key|
      sql = File.read(File.expand_path(key, __FILE__))
      ActiveRecord::Base.connection.execute(sql)
    end

  rescue => e
    print e
    print '='*100
  end

  Athens.configure do |config|
    config.output_location = SiteSetting.cribl_leaderboard_s3_query_output_location # Required
    if !SiteSetting.s3_use_iam_profile
      config.aws_access_key = SiteSetting.s3_access_key_id
      config.aws_secret_key = SiteSetting.s3_secret_access_key
    end
    config.aws_region = SiteSetting.s3_region
    config.wait_polling_period = 0.25 # Optional - What period should we poll for the complete query?
    config.result_encryption = nil
  end
end
