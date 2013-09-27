require 'faraday'
class DiscourseApi::Client

  attr_reader :host, :api_key

  def initialize(host, api_key=nil)
    @host = host
    @api_key = api_key
    @conn = Faraday.new(url: host) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def categories
    json = _get('/categories.json')
    json['category_list']['categories']
  end

  def topics_latest
    json = _get("/latest.json")
    json['topic_list']['topics']
  end

  def topics_hot
    json = _get("/hot.json")
    json['topic_list']['topics']
  end

  def topic(id)
    json = _get("/t/#{id}.json")
  end

  def topic_invite_user
    # post :topic_invite_user => "/t/:topic_id/invite", :require => [:email, :topic_id]
  end

  def post_create
    # post :post_create => "/posts", :require => [:raw]
  end

  private

  def _get(message)
    resp = @conn.get(message)
    JSON.parse(resp.body)
  end

end
