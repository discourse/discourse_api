class DiscourseApi::Client < DiscourseApi::Resource

  def initialize(host, port=80)
    @host = host
    @port = port
  end

  post :topic_invite_user => "/t/:topic_id/invite", :require => [:email, :topic_id]
  post :post_create => "/posts", :require => [:raw]
  get :topics_latest => "/latest.json"
  get :topics_hot => "/hot.json"
  get :categories => "/categories.json"

  get :users_honeypot => "/users/hp.json"
  post :create_user => "/users.json", :require => [:name, :username, :email, :password, :password_confirmation, :challenge]

  def create_user_past_honeypot(user_params)
    honeypot_response = JSON.parse self.users_honeypot({})

    user_params.merge!({
      password_confirmation: honeypot_response["value"],
      challenge: honeypot_response["challenge"].reverse
    })

    self.create_user(user_params)
  end
end
