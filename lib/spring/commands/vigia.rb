module Spring
  module Commands
    class Vigia
      def env(*)
        "test"
      end

      def call
        pid_file_path = File.expand_path("../../../tmp/pids/api_server.pid", __FILE__)
        pid           = File.exist?(pid_file_path) ? File.read(pid_file_path) : nil

        if pid.blank?
          # start rails server by the easiest way
          system("bin/rails s -e #{env} -d -p 3005 --pid #{pid_file_path}")
          # give some time to the server
          sleep 10
        end

        response_body_fufills_schema = -> do
          payload_name = resource_group.name.downcase.pluralize
          schema       = JSON.parse(response.schema)
          parsed_body  = JSON.parse(result.body)

          expect(parsed_body).to have_key payload_name

          expect{ JSON::Validator.validate!(schema, parsed_body[payload_name], list: true, strict: true) }.to_not raise_error
        end

        Vigia::Sail::Example.register('returns valid json', expectation: response_body_fufills_schema)

        Vigia.configure do |config|

          config.host        = 'http://api.vcap.me:3005'
          config.source_file = File.expand_path("../../../api_specification.apib", __FILE__)

          # Reset rspec_config and set up documentation formatter
          config.rspec_config do |rspec_config|
            rspec_config.reset
            rspec_config.formatter = ::RSpec::Core::Formatters::DocumentationFormatter

            rspec_config.after :all do
              system("kill -9 #{pid}")
            end
          end
        end

        Vigia.rspec!
      end
    end

    Spring.register_command "vigia", Vigia.new
  end
end
