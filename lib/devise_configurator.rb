def configure_devise
  install
  generate_user
  custom_views
  configure_mail
end

def install
  generate 'devise:install'
end

def generate_user
  generate 'devise User name:string surname:string telephone:integer address:string'
end

def custom_views
  generate 'devise:views'
end

def configure_mail
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'
end
