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

  def get_commit_id
    get_git.object('HEAD^').blob?
  end

  def get_current_branch
    get_git.branches.local
  end

  def get_release_version
    get_commit_id
  end

end