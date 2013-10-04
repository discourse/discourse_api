class DiscourseApi::Client < DiscourseApi::Resource

  def initialize(host, port=80, protocol='http')
    @host = host
    @port = port
    @protocol = protocol
  end

  post :topic_invite_user => "/t/:topic_id/invite", :require => [:email, :topic_id]
  post :post_create => "/posts", :require => [:raw]
  get :topics_latest => "/latest.json"
  get :topics_hot => "/hot.json"
  get :categories => "/categories.json"

  get :topic => "/t/:topic_id.json"

  # NOTE: If used on api username,
  # then the api username also needs to be changed
  put :user_update      => "/users/:username",
                        :require => [:username]

  put :username_update  => '/users/:username/preferences/username',
                        :require => [:username]

  # NOTE: Will send email activation
  put :email_update     => '/users/:username/preferences/email',
                        :require => [:username]

  put :toggle_avatar    => '/users/:username/preferences/avatar/toggle',
                        :require => [:username]

  post :upload_avatar    => '/users/:username/preferences/avatar',
                        :require => [:username]
end
