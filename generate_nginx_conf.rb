# frozen_string_literal: true

require 'erb'
require 'yaml'

class GenerateNginxConf
  def initialize
    @redirects = YAML.load_file('redirects.yml')['redirects']
  end

  def generate
    ERB.new(File.read('redirect-woozle.conf.erb'), trim_mode: '-').result(binding)
  end
end

puts GenerateNginxConf.new.generate
