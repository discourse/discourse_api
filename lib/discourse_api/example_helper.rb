# frozen_string_literal: true
require "yaml"

module DiscourseApi
  class ExampleHelper
    def self.load_yml
      config_yml = File.expand_path("../../../config.yml", __FILE__)
      puts config_yml
      begin
        config = YAML.load_file config_yml
      rescue Errno::ENOENT
        config = {}
      end
      config
    end
  end
end
