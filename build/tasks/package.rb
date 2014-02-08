require 'singleton'
require 'fileutils'
require 'zip'

class MyApp
  class Package

    include Singleton

    def task
      make_full_package
    end


    def get_temp_path
      MyApp.instance.get_release_path + '/temp'
    end

    def get_package_name_path
      path = get_temp_path + '/' + MyApp.instance.get_package_name
    end

    def copy_src_files
      package_path = 'build/' + get_package_name_path

      FileUtils.cd(MyApp.instance.get_src_root) do
        FileUtils.mkdir_p package_path
        Dir.glob('**/*').each do |file|
          if !match_path(file, src_ignore)
            if File.directory?(file)
              FileUtils.mkdir_p package_path + '/' + file
            else
              FileUtils.cp file, package_path + '/' + file
            end
          end
        end
      end

    end

    def make_full_package
      copy_src_files
      create_archive(
          get_package_name_path + '/',
          MyApp.instance.get_archive_path
      )
    end

    def match_path(path, patterns)
      patterns.each do |pattern|
        if File.fnmatch(pattern, path)
          return true
        end
      end
      return false
    end

    def src_ignore
      ['build**', '*README.md', '*.iml', '.git**']
    end

    def create_archive(src_dir, dest)
      puts 'Creating release archive: ' + dest
      Zip::File.open(dest, Zip::File::CREATE) do |zipfile|
        Dir[File.join(src_dir, '**', '**')].each do |file|
          zipfile.add(file.sub(src_dir, ''), file)
        end
      end
    end

  end
end

