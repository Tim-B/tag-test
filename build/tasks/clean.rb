class MyApp
  class Clean
    def self.task
      puts MyApp.instance.get_release_version
      puts 'Clean'
    end
  end
end
