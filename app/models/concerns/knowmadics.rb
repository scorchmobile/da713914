require 'active_support/concern'

module Knowmadics

    # Model Extension
    extend ActiveSupport::Concern

    included do

        # Attrs
        class_attribute :user_id, :api_key, :first_advantage, :knowmadics, :authorize_net

        # Get User Object
        # u = UserInterface.new user_id: ENV['KNOWMADICS_USERID']
        # u.get_user_subscription (auto)
        # uload_knowmadics_data (auto)
        def get_user_subscription(user_id)
            response = ::Net::HTTP.get_response(::URI.parse(ENV['KNOWMADICS_GET_USER_SUBSCRIPTION_URL'] + "?userId=#{user_id}")).body\
            # puts response.body, response.code, response.message, response.headers.inspect

            data = ::Nokogiri::XML response

            # Failure to Find User
            if !data.css('error').blank?
                #raise ArgumentError, "Could Not Find User on Knowmadics. Confirm the userId."
                return false
            else
                # Convert XML to JSON
                xml = ::Crack::XML.parse(response)
                json = ::JSON.parse(xml.to_json)
                @knowmadics = json["record"]

                # Set all the data
                name_parts = @knowmadics["name"].split(' ')
                name_parts = ['FIRST', 'MIDDLE', 'LAST']  if name_parts.count == 2
                @knowmadics["first_name"] = name_parts[0]
                @knowmadics["middle_name"] = name_parts[1]
                @knowmadics["last_name"] = name_parts[2]
                @knowmadics["org_name"] = ENV['KNOWMADICS_ORG_NAME']
                @knowmadics["user_id"] = user_id
                return @knowmadics
            end #END !data.css('error').blank?
        end #END def
        alias_method :load_knowmadics_data, :get_user_subscription

        # Pass in the UserInterface Object
        # u = UserInterface.new user_id: ENV['KNOWMADICS_USERID']
        # u.VAR = VAL
        # u.update!
        def set_user_subscription
            # Send the information to Knowmadics
            required_params = {
                apiKey: @api_key,
                userId: @user_id,
                subscriptionExpiryDate: @knowmadics['subscriptionExpiryDate'],
                userTypeId: @knowmadics['userTypeId'],
                subscrpitionProfileId: @knowmadics['subscrpitionProfileId'],
                customerProfileId: @knowmadics['customerProfileId'],
                addressProfileId: @knowmadics['addressProfileId'],
                paymentProfileId: @knowmadics['paymentProfileId']
            }
            cache = []
            required_params.each { |k, v| cache << k.to_s + '=' + v.to_s }
            response = ::HTTParty.get ENV['KNOWMADICS_SET_USER_SUBSCRIPTION_URL'] + '?' + cache.join('&')
            # puts response.body, response.code, response.message, response.headers.inspect

            data = ::Nokogiri::XML response.body

            # Failure to Find User
            if !data.css('error').blank?
                #raise ArgumentError, "Could Not Set the User Subscription Data on Knowmadics. Check the Logs."
                return false
            else
                return true
            end #END !data.css('error').blank?
        end #END def
        alias_method :update!, :set_user_subscription

    end #END included

    class_methods do
        # Create a User and make it available as a self Module command
        # form_data = { email: 'random@test.com', first_name: 'Test', last_name: 'Test', middle_name: 'Test', username: 'random@test.com', password: 'testtest' }
        # u = Knowmadics.create_user_account form_data
        def Knowmadics.create_user_account(form_data={})
            # Send the information to Knowmadics
            required_params = {
                apiKey: ENV['KNOWMADICS_API_KEY'],
                orgName: ENV['KNOWMADICS_ORG_NAME'],
                username: form_data[:username],
                password: form_data[:password], # Must be at least 8 long
                phone: form_data[:phone],
                email: form_data[:email],
                name: "#{form_data[:first_name]} #{form_data[:middle_name]} #{form_data[:last_name]}"
            }
            cache = []
            required_params.each { |k, v| cache << k.to_s + '=' + v.to_s }
            response = ::Net::HTTP.get_response(::URI.parse(ENV['KNOWMADICS_CREATE_USER_ACCOUNT_URL'] + '?' + cache.join('&'))).body
            data = ::Nokogiri::XML response

            # Failure to Find User
            if !data.css('error').blank?
                #raise ArgumentError, "#{data.css('error').first["value"]}. Check the Logs."
                return nil
            else
                user_id = data.css('userId').first.text
                return user_id
            end #END !data.css('error').blank?
        end #END def
    end #END class_methods

    # User email and password to authenticate
    # user_id = Knowmadics.sign_in(username, password)
    # u = UserInterface.new(user_id: user_id)
    def Knowmadics.sign_in(username, password)
        required_params = {
            username: username,
            password: password
        }

        cache = []
        required_params.each { |k, v| cache << k.to_s + '=' + v.to_s }
        response = ::Net::HTTP.get_response(::URI.parse(ENV['KNOWMADICS_CREATE_USER_ACCOUNT_URL'] + '?' + cache.join('&'))).body

        datapoints = response.split('|')    rescue nil
        user_id = datapoints[5]             rescue nil

        # Failure to Find User
        if user_id.blank?
            #raise ArgumentError, "Invalid Credentials."
            return nil
        else
            return user_id
        end #END !data.css('error').blank?
    end #END def

end
