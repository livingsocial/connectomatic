require 'rake'

# these still need some work...
namespace :db do

  namespace :connectomatic do

    def each_local_config
      Dir.glob("config/databases/*.yml") do |filename|
        YAML::load(File.open(filename)).each_value do |config|
          next unless config['database']
          local_database?(config) do
            yield config
          end
        end
      end
    end

    desc "Creates all databases defined in databases/*.yml"
    task :create_all do
      Rake::Task["db:create:all"].invoke
      each_local_config do |config|
        create_database(config)
      end
    end

    desc "Drops all databases defined in databases/*.yml"
    task :drop_all do
      Rake::Task["db:drop:all"].invoke
      each_local_config do |config|
        begin
          drop_database(config)
        rescue Exception => e
          $stderr.puts "Couldn't drop #{config['database']} : #{e.inspect}"
        end
      end
    end

  end

end
