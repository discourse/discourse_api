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

  def topics_latest
    resp = @conn.get("/latest.json")
    json = JSON.parse(resp.body)
    json['topic_list']['topics']
  end

  def topics_hot
    # get :topics_hot => "/hot.json"
  end

  def categories
    resp = @conn.get '/categories.json'
    json = JSON.parse(resp.body)
    json['category_list']['categories']
  end

  def topic_invite_user
    # post :topic_invite_user => "/t/:topic_id/invite", :require => [:email, :topic_id]
  end

  def topic
    # get :topic => "/t/:topic_id.json"
  end

  def post_create
    post :post_create => "/posts", :require => [:raw]
  end

end
