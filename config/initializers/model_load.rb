# Eager load all models in app/models
Dir[Rails.root.join('app', 'models', '*.rb').to_s].each {|file| require file }
