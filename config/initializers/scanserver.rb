Contact::Application.config.scanserver = YAML.load_file("config/scanserver.yml")[Rails.env]
