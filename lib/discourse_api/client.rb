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
end
