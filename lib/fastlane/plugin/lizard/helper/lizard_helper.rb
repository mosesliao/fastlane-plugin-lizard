module Fastlane
  module Helper
    class LizardHelper
      # class methods that you define here become available in your action
      # as `Helper::LizardHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the lizard plugin helper!")
      end
    end
  end
end
