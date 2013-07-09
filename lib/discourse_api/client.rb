class DiscourseApi::Client

  extend DiscourseApi::Resource

  def initialize(host,api_key)
    @host = host
    @api_key = api_key
  end

  resource :user do |r|
    r.post :invite, :require => [:email, :topic_id]
  end

end
