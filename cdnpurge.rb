module Fastlane
  module Actions
    module SharedValues
      CDNPURGE_CUSTOM_VALUE = :CDNPURGE_CUSTOM_VALUE
    end

    class CdnpurgeAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        # UI.message "Parameter API Token: #{params[:api_token]}"

        url = URI.parse(params[:cdnUrl])
        http = Net::HTTP.new(url.host, url.port)
        req = Net::HTTP::Get.new(url.request_uri)
        response = http.request(req)
        result = CGI::parse(response.body)
        puts result['status']

        UI.message "Result: #{result['status']}"

        # Actions.lane_context[SharedValues::CDNPURGE_CUSTOM_VALUE] = "my_val"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "CDN 서버 Purge를 위한 Action"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :cdnUrl,
                                      env_name: "FL_CDNPURGE_CDN_URL", # The name of the environment variable
                                      description: "Cdn Url for CdnpurgeAction", # a short description of this parameter
                                      verify_block: proc do |value|
                                          UI.user_error!("No Url for CdnpurgeAction given, pass using `cdnUrl: 'url'`") unless (value and not value.empty?)
                                          # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                      end),
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['CDNPURGE_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Yi Seong Zin"]
      end

      def self.is_supported?(platform)
        # you can do things like
        #
        #  true
        #
        #  platform == :ios
        #
        #  [:ios, :mac].include?(platform)
        #

        platform == :ios
      end
    end
  end
end
