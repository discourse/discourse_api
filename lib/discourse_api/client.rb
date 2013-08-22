class DiscourseApi::Client < DiscourseApi::Resource

  def initialize(host, port=80)
    @host = host
    @port = port
  end

  post :topic_invite_user => "/t/:topic_id/invite", :require => [:email, :topic_id]
  get :topics_latest => "/latest.json"
  get :topics_hot => "/hot.json"
  get :categories => "/categories.json"

end