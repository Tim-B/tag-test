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

  def is_tag?
    get_git.object('HEAD^').tag?
  end

  def get_current_branch
    get_git.branches.local
  end

  def get_release_version
    is_tag?
  end

end