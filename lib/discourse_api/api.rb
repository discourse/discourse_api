require 'faraday'
class DiscourseApi::Api

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

  def post_create(args)
    json = _post("/posts.json", args)
  end

  def user(username)
    json = _get("/user/#{username}.json")['user']
  end

  # NOTE: If used on api username,
  # then the api username also needs to be changed
  def user_update(username, user_params = {})
  # put :user_update      => "/users/:username",
  #                       :require => [:username]
  # puts client.user_update(username: "Batman", name: "Bruce Wayne")
    json = _put("/users/#{username}", user_params)
  end

  def username_update(username, new_username)
    json = _put("/users/#{username}/preferences/username", {new_username: new_username})
  end

  # NOTE: Will send email activation
  def email_update(username, email)
    json = _put("/users/#{username}/preferences/email", {email: email})
  end

  def toggle_avatar(username, use_uploaded_avatar)
    json = _put("/users/#{username}/preferences/avatar/toggle", {use_uploaded_avatar: use_uploaded_avatar})
  end

  def upload_avatar(username, file)
    json = _post("/users/#{username}/preferences/avatar", {file: file})
  end

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

  def _put(message, args)
    args = args.merge(api_key: @api_key, api_username: @api_username)

    resp = @conn.put do |req|
      req.url message
      # req.headers['Content-Type'] = 'application/json'
      req.body = args#.to_json
    end

    resp.status
  end
end
