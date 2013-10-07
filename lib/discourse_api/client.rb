require 'faraday'
class DiscourseApi::Client

  attr_reader :host, :api_key, :api_username

  def initialize(host, api_key=nil, api_username=nil)
    @host = host
    @api_key = api_key
    @api_username = api_username
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

  def topic_invite_user(email, id)
    # post :topic_invite_user => "/t/:topic_id/invite", :require => [:email, :topic_id]
    json = _post("/t/#{id}/invite.json", email: email, topic_id: id)
  end

  def post_create
    # post :post_create => "/posts", :require => [:raw]
  end

  # NOTE: If used on api username,
  # then the api username also needs to be changed
  # put :user_update      => "/users/:username",
  #                       :require => [:username]

  # put :username_update  => '/users/:username/preferences/username',
  #                       :require => [:username]

  # # NOTE: Will send email activation
  # put :email_update     => '/users/:username/preferences/email',
  #                       :require => [:username]

  # put :toggle_avatar    => '/users/:username/preferences/avatar/toggle',
  #                       :require => [:username]

  private

  def _get(message)
    resp = @conn.get(message)
    JSON.parse(resp.body)
  end

  def _post(message, args)
    args = args.merge(api_key: @api_key, api_username: @api_username, topic: {})

    resp = @conn.post do |req|
      req.url message
      req.headers['Content-Type'] = 'application/json'
      req.body = args.to_json
    end

    resp.status

  end

end
