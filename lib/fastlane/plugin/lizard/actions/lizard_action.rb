module Fastlane
  module Actions
    class LizardAction < Action
      def self.run(params)
        if params[:executable].nil? && `which lizard`.to_s.empty?
          UI.user_error!("You have to install lizard using `[sudo] pip install lizard` or specify the executable path with the `:executable` option.")
        end

        if params[:executable] && !File.exist?(params[:executable])
          UI.user_error!("The custom executable at '#{params[:executable]}' does not exist.")
        end

        lizard_cli_version = Gem::Version.new(`lizard --version`.scan(/(?:\d+\.?){3}/).first)
        required_version = Gem::Version.new(Fastlane::Lizard::CLI_VERSION)
        if lizard_cli_version < required_version
          UI.user_error!("Your lizard is outdated, please upgrade to at least version #{Fastlane::Lizard::CLI_VERSION} and start your lane again!")
        end

        command = forming_command(params)

        begin
          Actions.sh(command.join(" "), log: false)
        rescue StandardError => e
          puts e
          handle_lizard_error(params[:ignore_exit_status], $CHILD_STATUS.exitstatus)
        end
      end

      def self.forming_command(params)
        command = []
        command << 'lizard' unless params[:executable]
        command << "python #{params[:executable]}" if params[:executable]
        command << params[:language].split(",").map { |l| "-l #{l.strip}" }.join(" ") if params[:language]
        command << "--#{params[:export_type]}" if params[:export_type]
        command << "-C #{params[:ccn]}" if params[:ccn] # stands for cyclomatic complexity number
        command << "-L #{params[:length]}" if params[:length]
        command << "-a #{params[:arguments]}" if params[:arguments]
        command << "-i #{params[:number]}" if params[:number]
        command << "-x #{params[:exclude]}" if params[:exclude]
        command << "-t #{params[:working_threads]}" if params[:working_threads]
        command << "-E #{params[:extensions]}" if params[:extensions]
        command << "-s #{params[:sorting]}" if params[:sorting]
        command << "-W #{params[:whitelist]}" if params[:whitelist]
        command << params[:source_folder].to_s if params[:source_folder]
        command << "> #{params[:report_file].shellescape}" if params[:report_file]

        return command
      end

      def self.handle_lizard_error(ignore_exit_status, exit_status)
        if ignore_exit_status
          failure_suffix = 'which would normally fail the build.'
          secondary_message = 'fastlane will continue because the `ignore_exit_status` option was used! 🙈'
        else
          failure_suffix = 'which represents a failure.'
          secondary_message = 'If you want fastlane to continue anyway, use the `ignore_exit_status` option. 🙈'
        end

        UI.important("")
        UI.important("Lizard finished with exit code #{exit_status}, #{failure_suffix}")
        UI.important(secondary_message)
        UI.important("")
        UI.user_error!("Lizard finished with errors (exit code: #{exit_status})") unless ignore_exit_status
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Run lizard code cyclomatic complexity analysis."
      end

      def self.authors
        ["liaogz82"]
      end

      def self.details
        "It counts 1)the nloc (lines of code without comments), 2)CCN (cyclomatic complexity number), 3)token count of functions. 4)parameter count of functions."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :source_folder,
                                       env_name: "FL_LIZARD_SOURCE_FOLDER",
                                       description: "The folders that contains the source code for lizard to scan",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :language,
                                       env_name: "FL_LIZARD_LANGUAGE",
                                       description: "List the programming languages you want to analyze, e.g. 'swift,objectivec'",
                                       default_value: "swift",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :export_type,
                                       env_name: "FL_LIZARD_EXPORT_TYPE",
                                       description: "The file extension of your export. E.g. xml, csv, html",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :ccn,
                                       env_name: "FL_LIZARD_CCN",
                                       description: "Threshold of cyclomatic complexity number warning",
                                       is_string: false,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :length,
                                       env_name: "FL_LIZARD_LENGTH",
                                       description: "Threshold for maximum function length warning",
                                       is_string: false,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :arguments,
                                       env_name: "FL_LIZARD_ARGUMENTS",
                                       description: "Limit for number of parameters",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :number,
                                      env_name: "FL_LIZARD_NUMBER",
                                      description: "If the number of warnings is equal or less than the number, the tool will exit normally, otherwise it will generate error. Useful in makefile for legacy code",
                                      is_string: false,
                                      optional: true),
          FastlaneCore::ConfigItem.new(key: :exclude,
                                      env_name: "FL_LIZARD_EXCLUDE",
                                      description: "Exclude files that match this pattern. * matches everything, ? matches any single character, \"./folder/*\" exclude everything in the folder recursively. Multiple patterns can be specified. Don't forget to add \"\" around the pattern",
                                      optional: true),
          FastlaneCore::ConfigItem.new(key: :working_threads,
                                       env_name: "FL_LIZARD_WORKING_THREADS",
                                       description: "Number of working threads. A bigger number can fully utilize the CPU and faster",
                                       optional: true,
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :extensions,
                                      env_name: "FL_LIZARD_EXTENSIONS",
                                      description: "User the extensions. The available extensions are: -Ecpre: it will ignore code in the #else branch. -Ewordcount: count word frequencies and generate tag cloud. -Eoutside: include the global code as one function",
                                      is_string: true,
                                      optional: true),
          FastlaneCore::ConfigItem.new(key: :sorting,
                                      env_name: "FL_LIZARD_SORTING",
                                      description: "Sort the warning with field. The field can be nloc, cyclomatic_complexity, token_count, parameter_count, etc. Or an customized file",
                                      optional: true),
          FastlaneCore::ConfigItem.new(key: :whitelist,
                                      env_name: "FL_LIZARD_WHITELIST",
                                      description: "The path and file name to the whitelist file",
                                      optional: true),
          FastlaneCore::ConfigItem.new(key: :report_file,
                                       env_name: "FL_LIZARD_REPORT_FILE",
                                       description: "The folder/file which lizard output to",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :ignore_exit_status,
                                      description: "Ignore the exit status of the lizard command, so that serious violations don't fail the build (true/false)",
                                      default_value: false,
                                      is_string: false,
                                      optional: true),
          FastlaneCore::ConfigItem.new(key: :executable,
                                      description: "Path to the `lizard.py` executable on your machine",
                                      is_string: true,
                                      optional: true)
        ]
      end

      def self.is_supported?(platform)
        [:ios, :android, :mac].include?(platform)
      end
    end
  end
end
