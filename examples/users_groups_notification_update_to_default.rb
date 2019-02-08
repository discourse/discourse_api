$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new('http://localhost:3000')
client.api_key = ENV['LOCAL_DISCOURSE_API']
client.api_username = 'KM_Admin'

# testing variables
# @target_username = 'some_test_username'
@@target_username = nil  # comment this and uncomment the above to test on a single user


def member_notifications(client, user)
  puts "#{user['id']} #{user['name']}"
  @users_username = user['username']
  @users_groups = client.user(@users_username)['groups']

  @users_group_users = client.user(@users_username)['group_users']
  @users_group_users.each do |users_group|
    @user_group_id = users_group['group_id']
    @notification_level = users_group['notification_level']
    @users_groups.each do |group|
      if group['id'] == @user_group_id
        @group_name = group['name']
        @default_level = group['default_notification_level']
      end
    end
    if @notification_level != @default_level
      puts "Group ID:#{@user_group_id} #{@group_name}    Notification Level: #{@notification_level}    Default: #{@default_level}"
      response = client.set_group_user_note_lev(@group_name, user['id'], @default_level)
      puts response
      @users_group_users_after_update = client.user(@users_username)['group_users']

      # uncomment to print each update just made to terminal
      # @users_group_users_after_update.each do |users_group_second_pass|
      #   if users_group_second_pass['group_id'] == @user_group_id
      #     puts "Updated ID:#{@user_group_id} #{@group_name}    Notification Level: #{users_group_second_pass['notification_level']}    Default: #{@default_level}"
      #   end
      # end

    end
  end
end


retrieve_next = 1
while retrieve_next > 0
  @users = client.list_users('active', page: retrieve_next)
  if @users.empty?
    retrieve_next = 0
  else
    # puts "Page .................. #{retrieve_next}"
    @users.each do |user|
      if @target_username
        if user['username'] == @target_username
          member_notifications(client, user)
        end
      else
        member_notifications(client, user)
        sleep(10) # needed to avoid the DiscourseApi::TooManyRequests limit
      end
    end
    retrieve_next += 1
  end
end
