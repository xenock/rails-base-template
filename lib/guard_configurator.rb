require_relative './file_creator.rb'

def configure_guard
  add_guard_file
end

def add_guard_file
  file 'Guardfile', render_file(path('Guardfile'))
end
