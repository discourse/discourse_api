# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

@target_username = "YOUR_TARGET_USERNAME"
@target_group_id = # YOUR NUMERIC TARGET GROUP ID
  @user = client.user(@target_username)

# each user's group and the group's default notification level are stored under user['groups']
@user["groups"].each do |group|
  if group["id"] == @target_group_id
    @group_name = group["name"]
    @default_level = group["default_notification_level"]
  end
end

# and the user's notification setting for each group is stored under user['group_users]
@user["group_users"].each do |users_group|
  if users_group["group_id"] == @target_group_id
    @notification_level = users_group["notification_level"]
    puts "Group ID:#{@target_group_id} #{@group_name}    Current Notification Level: #{@notification_level}    Default: #{@default_level}"
    response = client.group_set_user_notification_level(@group_name, @user["id"], @default_level)
    puts response
    @users_group_users_after_update = client.user(@target_username)["group_users"]
    # this just pulls the user from the database again to make sure we updated the user's group notification level
    @users_group_users_after_update.each do |users_group_second_pass|
      if users_group_second_pass["group_id"] == @target_group_id
        puts "Updated ID:#{@target_group_id} #{@group_name}    Notification Level: #{users_group_second_pass["notification_level"]}    Default: #{@default_level}"
      end
    end
  end
end
