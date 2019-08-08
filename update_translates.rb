require 'yaml'
require 'transifex'

require 'pry'

SECRETS_FILE = 'secrets.yml'.freeze
INPUT_LANGUAGE = :en
OUTPUT_LANGUAGES = [:ru, :ar_SA]
PROJECT_NAME = 'merchantly'

secrets = YAML.load_file(SECRETS_FILE)

client = Transifex::Client.new username: secrets['username'], password: secrets['password']

project = client.project(PROJECT_NAME)

Dir.entries(INPUT_LANGUAGE.to_s).each do |file|
  resource_slug = file.gsub('_', '-').gsub('.', '-') + '--master'

  resource = project.resource(resource_slug)

  OUTPUT_LANGUAGES.each do |lang|
    translation = resource.translation(lang)

    File.open("#{lang}/#{file}", 'w') do |out|
      out.write(translation['content'])
    end
  end
end
