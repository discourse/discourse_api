class DiscourseApi::ParsedPath
  def initialize(path, args)
    @segments = path.split("/")[1..-1] || []
    @required = Set.new
    @path_args = Set.new

    if reqs = args[:required]
      reqs.each{|r| @required << r.to_sym}
    end

    @segments.map{|s| param_name(s)}.compact.each do |r|
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
    path = ""
    @segments.each do |s|
      path << "/"
      if n = param_name(s)
        path << args[n.to_sym].to_s
      else
        path << s
      end
    end

    extra_args = args.dup.delete_if{|k,v| @path_args.include?(k.to_s)}

    [path, extra_args]
  end

  protected

  def param_name(segment)
    if segment[0] == ":"
      segment[1..-1]
    end
  end
end
