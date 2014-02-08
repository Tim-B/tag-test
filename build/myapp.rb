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
        tag
      end
    end
    return false
  end

  def get_current_branch
    get_git.current_branch
  end

  def get_release_version
    tag = is_tag?
    if tag
      return tag.name
    end
    return 'branch-' + get_current_branch
  end

  def get_package_name
    'myapp-' + get_release_version
  end

  def get_release_path
    'release'
  end

  def get_src_root
    '..'
  end

  def get_archive_name(prefix = '')
    prefix + get_package_name + '.zip'
  end

  def get_archive_path(prefix = '')
    get_release_path + '/' + get_archive_name
  end

end