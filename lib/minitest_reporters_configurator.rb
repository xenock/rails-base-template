require_relative './file_creator.rb'

def configure_minitest_reporters
  remove_test_helper
  add_test_helper
end

def remove_test_helper
  remove_file 'test/test_helper.rb'
end

def add_test_helper
  file 'test/test_helper.rb', render_file(path('test_helper.rb'))
end
