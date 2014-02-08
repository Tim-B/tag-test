require 'git'
require 'singleton'

class MyApp

  include Singleton

  def get_git
    if @git == nil
      @git = Git.open('../')
    end
    @git
  end

  def get_release_version
    get_git.status
  end

end