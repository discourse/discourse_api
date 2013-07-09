module DiscourseApi::Resource
  def self.resource(name)
    yield self.new(name, self)
  end

  def initialize(name, client)
    @name = name
    @client = client
  end

  def post(name, opts={})

  end
end
