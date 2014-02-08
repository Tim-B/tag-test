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

  def get_current_sha
    get_git.object('HEAD').sha
  end


  def is_tag?
    my_sha = get_current_sha
    get_git.tags.each do |tag|
      if tag.sha == my_sha
        return true
      end
    end
    return false
  end

  def get_current_branch
    get_git.branches.local
  end

  def get_release_version
    is_tag?
  end

end