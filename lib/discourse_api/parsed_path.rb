class DiscourseApi::ParsedPath
  def initialize(path, args)
    @path = path
    @required = Set.new
    @path_args = Set.new

    if reqs = args[:required]
      reqs.each{|r| @required << r.to_sym}
    end

    @path.scan(/:(\w+)/).flatten.each do |r|
      @required << r.to_sym
      @path_args << r
    end
  end

  def validate!(args)
    missing = @required - args.keys
    if missing.length > 0
      raise ArgumentError.new("Missing: #{missing.to_a.join(",")}")
    end
  end

  def generate(args)
    path = @path.dup

    @path_args.each do |s|
      path.gsub!(":#{s}", args[s.to_sym].to_s)
    end

    extra_args = args.dup.delete_if{|k,v| @path_args.include?(k.to_s)}

    [path, extra_args]
  end

end
