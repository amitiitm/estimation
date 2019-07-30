APP_CONFIG = YAML.load_file("#{Rails.root}/config/app_config.yml")[Rails.env]
PAGINATION_COUNT = 10
ADMIN = 'Admin'
SME = 'SME'
CLIENT = 'Client'

Date::DATE_FORMATS[:default] = "%d/%m/%Y"
Time::DATE_FORMATS[:default] = "%d/%m/%Y %H:%M"