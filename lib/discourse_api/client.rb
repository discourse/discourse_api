require 'faraday'
class DiscourseApi::Client

  def initialize(host, api_key=nil)
    @conn = Faraday.new(url: host) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  # get :topics_latest => "/latest.json"
  # get :topics_hot => "/hot.json"
  # get :categories => "/categories.json"

  def topics_latest
    resp = @conn.get("/latest.json")
    JSON.parse(resp.body)
  end

  def topics_hot
  end

  def categories
  end

  def topic_invite_user
  end

end
