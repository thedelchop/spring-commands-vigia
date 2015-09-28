module Spring
  module Commands
    class Vigia
      def env(*)
        "test"
      end

      def exec_name
        'vigia'
      end

      def gem_name
        'spring-commands-vigia'
      end

      def call
        load Gem.bin_path(gem_name, exec_name)
      end
    end

    Spring.register_command "vigia", Vigia.new
  end
end
