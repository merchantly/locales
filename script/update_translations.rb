require 'transifex'

SECRETS_FILE = 'secrets.yml'.freeze
INPUT_LANGUAGE = :en
OUTPUT_LANGUAGES = [:ru, :ar_SA].freeze
PROJECT_NAME = 'merchantly'.freeze

secrets = YAML.load_file(SECRETS_FILE)

client = Transifex::Client.new username: secrets['username'], password: secrets['password']

project = client.project(PROJECT_NAME)

Dir.entries("../#{INPUT_LANGUAGE}").each do |file|
  resource_slug = file.tr('_', '-').tr('.', '-') + '--master'

  p "#{resource_slug} start"

  begin
    resource = project.resource(resource_slug)
  rescue Transifex::NotFound
    p "#{resource_slug} no found"
    next
  end

  OUTPUT_LANGUAGES.each do |lang|
    translation = resource.translation(lang)

    File.open("../#{lang}/#{file}", 'w') do |out|
      out.write(translation['content'])
    end
  end

  p "#{resource_slug} success"
end
