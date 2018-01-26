module Fastlane
  module Actions
    class LizardAction < Action
      def self.run(params)
        command = ["lizard #{params[:source_folder]}"]
        command << "-l #{params[:language]}" if params[:language]
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
        command << "> ./#{params[:report_file]}"

        if params[:show_warnings]
          Fastlane::Actions.sh_control_output(command.join(" ") + " | sed -n -e '/^$/,$p'", print_command: true, print_command_output: true)
        else
          Fastlane::Actions.sh_control_output(command.join(" "), print_command: false, print_command_output: false)
        end
      end

      def self.description
        "Lizard is an extensible Cyclomatic Complexity Analyzer for many imperative programming languages including C/C++ "
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
                                       verify_block: proc do |value|
                                         UI.user_error!("No source folder specified") unless value and !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :language,
                                       env_name: "FL_LIZARD_LANGUAGE",
                                       description: "List the programming languages you want to analyze",
                                       default_value: "swift"),
          FastlaneCore::ConfigItem.new(key: :export_type,
                                      env_name: "FL_LIZARD_EXPORT_TYPE",
                                      description: "The file extension of your export. E.g. xml, csv"),
          FastlaneCore::ConfigItem.new(key: :ccn,
                                       env_name: "FL_LIZARD_CCN",
                                       description: "Threshold of cyclomatic complexity number warning",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :length,
                                      env_name: "FL_LIZARD_LENGTH",
                                      description: "Threshold for maximum function length warning",
                                      optional: true),
          FastlaneCore::ConfigItem.new(key: :arguments,
                                      env_name: "FL_LIZARD_ARGUMENTS",
                                      description: "Limit for number of parameters",
                                      optional: true),
          FastlaneCore::ConfigItem.new(key: :number,
                                      env_name: "FL_LIZARD_NUMBER",
                                      description: "If the number of warnings is equal or less than the number, the tool will exit normally, otherwise it will generate error. Useful in makefile for legacy code",
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
                                       description: "The folder/file which lizard output to"),
          FastlaneCore::ConfigItem.new(key: :show_warnings,
                                      env_name: "FL_LIZARD_SHOW_WARNINGS",
                                      description: "Show lizard warnings on console",
                                      is_string: false,
                                      default_value: false)
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
