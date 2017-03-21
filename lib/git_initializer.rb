def initialize_git
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end

def remove_gitignore
  remove_file  ".gitignore"
end

def custom_gitignore
  file ".gitignore", render_file(path("gitignore"))
end
