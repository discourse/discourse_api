class DiscourseApi::Client < DiscourseApi::Resource

  def initialize(host)
    @host = host
  end

  post :topic_invite_user => "/t/:topic_id/invite", :require => [:email, :topic_id]

end
