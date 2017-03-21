require_relative './file_creator.rb'

def remove_gemfile
  remove_file "Gemfile"
end

def custom_gemfile
  file "Gemfile", render_file(path("Gemfile"))
end
