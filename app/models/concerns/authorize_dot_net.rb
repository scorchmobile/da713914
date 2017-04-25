require 'active_support/concern'
require 'authorizenet'

module AuthorizeDotNet

    # Payment Objects
    include AuthorizeNet::API

    # Model Extension
    extend ActiveSupport::Concern

    included do

        # Attres
        class_attribute :user_id, :api_key, :first_advantage, :knowmadics, :authorize_net

        # Load the IDs
        def load_authortize_net_data(knowmadics_data={})
          @authorize_net = {}
          @authorize_net["user_type_id"] =    knowmadics_data["userTypeId"]
          @authorize_net["profile_id"] =      knowmadics_data["customerProfileId"]
          @authorize_net["address_id"] =      knowmadics_data["addressProfileId"]
          @authorize_net["payment_id"] =      knowmadics_data["paymentProfileId"]
          @authorize_net["subscription_id"] = knowmadics_data["subscriptionProfileId"]
          return @authorize_net
        end #END def

        # Find Transaction
        # u = UserInterface.new user_id: ENV['KNOWMADICS_USERID']
        # u.find_authorize_net_customer(u.authorize_net['transaction_id'])
        def find_authorize_net_transaction(transaction_id)
          # Start the Transaction
          transaction = AuthorizeNet::API::Transaction.new(ENV['AUTHORIZE_NET_KEY'], ENV['AUTHORIZE_NET_SECRET'], {gateway: ENV['AUTHORIZE_NET_ENV'].to_sym})

          transId = transaction_id
          request = AuthorizeNet::API::GetTransactionDetailsRequest.new
          request.transId = transId

          #standard api call to retrieve response
          response = transaction.get_transaction_details(request)

          if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
            puts "Get Transaction Details Successful "
            puts "Transaction Id:   #{response.transaction.transId}"
            puts "Transaction Type:   #{response.transaction.transactionType}"
            puts "Transaction Status:   #{response.transaction.transactionStatus}"
            printf("Auth Amount:  %.2f\n", response.transaction.authAmount)
            printf("Settle Amount:  %.2f\n", response.transaction.settleAmount)
          else
            puts response.messages.messages[0].code
            puts response.messages.messages[0].text
            raise "Failed to get transaction Details."
          end

          return response
        end

        # Find Subscription
        # u = UserInterface.new user_id: ENV['KNOWMADICS_USERID']
        # u.find_authorize_net_customer(u.authorize_net['subscription_id'])
        def find_authorize_net_subscription(subscription_id)
          # Start the Transaction
          transaction = AuthorizeNet::API::Transaction.new(ENV['AUTHORIZE_NET_KEY'], ENV['AUTHORIZE_NET_SECRET'], {gateway: ENV['AUTHORIZE_NET_ENV'].to_sym})

          request = AuthorizeNet::API::ARBGetSubscriptionRequest.new

          #request.refId = 'Sample' ?
          request.subscriptionId = subscription_id

          response = transaction.arb_get_subscription_request(request)

          if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
            puts "Successful got ARB subscription"
            puts response.messages.messages[0].code
            puts response.messages.messages[0].text
            puts "Subscription name = #{response.subscription.name}"
            puts "Payment schedule start date = #{response.subscription.paymentSchedule.startDate}"
            puts "Payment schedule Total Occurrences = #{response.subscription.paymentSchedule.totalOccurrences}"
            puts "Subscription amount = #{response.subscription.amount}"
            puts "Subscription profile description = #{response.subscription.profile.description}"
            puts "First Name in Billing Address = #{response.subscription.profile.paymentProfile.billTo.firstName}"

          else
            puts response.messages.messages[0].code
            puts response.messages.messages[0].text
            raise "Failed to get ARB subscription"
          end

          return response
        end

        # Find Address
        # u = UserInterface.new user_id: ENV['KNOWMADICS_USERID']
        # u.find_authorize_net_customer(u.authorize_net['address_id'])
        def find_authorize_net_address(profile_id, address_id)
          # Start the Transaction
          transaction = AuthorizeNet::API::Transaction.new(ENV['AUTHORIZE_NET_KEY'], ENV['AUTHORIZE_NET_SECRET'], {gateway: ENV['AUTHORIZE_NET_ENV'].to_sym})

          request = AuthorizeNet::API::GetCustomerShippingAddressRequest.new
          request.customerProfileId = customerProfileId
          request.customerAddressId = customerAddressId

          response = transaction.get_customer_shipping_profile(request)


          if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
            puts "Successfully retrieved a shipping address with profile id #{request.customerAddressId} and whose customer id is #{request.customerProfileId}"

            if response.subscriptionIds != nil && response.subscriptionIds.subscriptionId != nil
              puts "List of subscriptions : "
              response.subscriptionIds.subscriptionId.each do |subscriptionId|
                puts "#{subscriptionId}"
              end
            end

          else
            raise "#{response.messages.messages[0].text} -- Failed to get payment profile information with id #{request.customerProfileId}"
          end
          return response
        end

        # Find Profile
        # u = UserInterface.new user_id: ENV['KNOWMADICS_USERID']
        # u.find_authorize_net_customer(u.authorize_net['customer_id'])
        def find_authorize_net_customer(customer_id)
          # Start the Transaction
          transaction = AuthorizeNet::API::Transaction.new(ENV['AUTHORIZE_NET_KEY'], ENV['AUTHORIZE_NET_SECRET'], {gateway: ENV['AUTHORIZE_NET_ENV'].to_sym})

          request = AuthorizeNet::API::GetCustomerProfileRequest.new
          request.customerProfileId = customerProfileId

          response = transaction.get_customer_profile(request)

          if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
            puts "Successfully retrieved a customer with profile id is #{request.customerProfileId} and whose customer id is #{response.profile.merchantCustomerId}"
            response.profile.paymentProfiles.each do |paymentProfile|
              puts "Payment Profile ID #{paymentProfile.customerPaymentProfileId}"
              puts "Payment Details:"
              if paymentProfile.billTo != nil
                puts "Last Name #{paymentProfile.billTo.lastName}"
                puts "Address #{paymentProfile.billTo.address}"
              end
            end
            response.profile.shipToList.each do |ship|
              puts "Shipping Details:"
              puts "First Name #{ship.firstName}"
              puts "Last Name #{ship.lastName}"
              puts "Address #{ship.address}"
              puts "Customer Address ID #{ship.customerAddressId}"
            end

            if response.subscriptionIds != nil && response.subscriptionIds.subscriptionId != nil
              puts "List of subscriptions : "
              response.subscriptionIds.subscriptionId.each do |subscriptionId|
                puts "#{subscriptionId}"
              end
            end

          else
            puts response.messages.messages[0].text
            raise "Failed to get customer profile information with id #{request.customerProfileId}"
          end

          return response
        end

        # Create the User on Merchant Account
        # See user_interface.rb => def create_authnet_accounts(form_data={})
        def create_authortize_net_profiles(form_data={})
            everything_worked = false

            # Set the Amount
            membership_type_code = form_data[:user_type_id].to_i
            case membership_type_code
            when 3 then amount = ENV['SUBSCRIPTION_COST_CITIZEN']   # Citizen
            when 4 then amount = ENV['SUBSCRIPTION_COST_DEPUTY']    # Deputy
            when 6 then amount = ENV['SUBSCRIPTION_COST_FAMILY3']   # Family 3
            when 5 then amount = ENV['SUBSCRIPTION_COST_FAMILY6']   # Family 6
            end

            # Create Customer Profile
            profile_id = create_user_profile()
            if profile_id != 0
              # Create Customer Payment Profile
              payment_id = create_payment_profile(form_data, profile_id)
              if payment_id != 0
                # Create Customer Shipping Profile
                address_id = create_shipping_profile(form_data, profile_id)
                if address_id != 0
                  # Create Customer Subscription
                  subscription_id = create_subscription(amount, profile_id, payment_id, address_id)
                  if subscription_id != 0
                    everything_worked = true
                    @authorize_net_data = {
                        'subscription_id' => subscription_id,
                        'address_id'      => address_id,
                        'payment_id'      => payment_id,
                        'profile_id'      => profile_id,
                        'user_type_id'    => membership_type_code.to_s
                    }

                    return @authorize_net_data
                  else
                    raise ArgumentError, 'Customer Subscription Failed (4/4)'
                  end #END subscription_id != 0
                else
                  raise ArgumentError, 'Customer Shipping Profile Failed (3/4)'
                end #END address_id != 0
              else
                raise ArgumentError, 'Customer Payment Profile Failed (2/4)'
              end #END payment_id != 0
            else
              raise ArgumentError, 'Customer Profile Failed (1/4)'
            end #END profile_id != 0
        end #END def

        private

        # Create the Customer Profile
        # See user_interface.rb => def create_authnet_accounts(form_data={})
        # See authorize_dot_net.rb => def create_authnet_accounts(form_data={})
        def create_user_profile
          # Start the Transaction
          transaction = AuthorizeNet::API::Transaction.new(ENV['AUTHORIZE_NET_KEY'], ENV['AUTHORIZE_NET_SECRET'], {gateway: ENV['AUTHORIZE_NET_ENV'].to_sym})

          # Create the Customer Profile and get the Customer ID
          request = AuthorizeNet::API::CreateCustomerProfileRequest.new
          request.profile = AuthorizeNet::API::CustomerProfileType.new @knowmadics["user_id"],
                                                    "#{@knowmadics['first_name']} #{@knowmadics['last_name']}",
                                                    @knowmadics["user_id"],
                                                    nil,
                                                    nil
          response = transaction.create_customer_profile(request)

          # If it works, return the profile id
          if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
            return response.customerProfileId
          else
            puts response.messages.messages[0].text
            raise ArgumentError, "Failed to create a new customer profile."
            return false
          end
        end #END def

        # Create the Payment Profile for the Existing Customer Profile
        # See user_interface.rb => def create_authnet_accounts(form_data={})
        # See authorize_dot_net.rb => def create_authnet_accounts(form_data={})
        def create_payment_profile(payment_params={}, profile_id)
          # Start the Transaction
          transaction = AuthorizeNet::API::Transaction.new(ENV['AUTHORIZE_NET_KEY'], ENV['AUTHORIZE_NET_SECRET'], gateway: ENV['AUTHORIZE_NET_ENV'].to_sym)
          # Initialize the Payment
          request = AuthorizeNet::API::CreateCustomerPaymentProfileRequest.new
          # Payment Profile
          payment = AuthorizeNet::API::PaymentType.new(AuthorizeNet::API::CreditCardType.new(payment_params[:cc_number], "#{payment_params[:cc_year]}-#{payment_params[:cc_month]}"))
          profile = AuthorizeNet::API::CustomerPaymentProfileType.new(nil,nil,payment,nil,nil)
          profile.billTo = AuthorizeNet::API::CustomerAddressType.new
          profile.billTo.firstName = @knowmadics["first_name"]
          profile.billTo.lastName = @knowmadics["last_name"]
          profile.billTo.address = payment_params[:billing_street1]
          profile.billTo.city = payment_params[:billing_city]
          profile.billTo.state = payment_params[:billing_state]
          profile.billTo.zip = payment_params[:billing_zipcode]
          request.paymentProfile = profile
          request.customerProfileId = profile_id
          # Create Payment
          response = transaction.create_customer_payment_profile(request)

          if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
            return response.customerPaymentProfileId
          else
            raise ArgumentError, "#{response.messages.messages[0].text} -- Failed to create a new customer payment profile."
            return false
          end
        end #END def

        # Create the Shipping Profile for the Existing Customer Profile
        # See user_interface.rb => def create_authnet_accounts(form_data={})
        # See authorize_dot_net.rb => def create_authnet_accounts(form_data={})
        def create_shipping_profile(payment_params={}, profile_id)
          # Start the Transaction
          transaction = AuthorizeNet::API::Transaction.new(ENV['AUTHORIZE_NET_KEY'], ENV['AUTHORIZE_NET_SECRET'], {gateway: ENV['AUTHORIZE_NET_ENV'].to_sym})
          # Initialize the Shipping
          request = AuthorizeNet::API::CreateCustomerShippingAddressRequest.new
          # Shipping Profile
          request.address = AuthorizeNet::API::CustomerAddressType.new
          request.address.firstName = @knowmadics["first_name"]
          request.address.lastName = @knowmadics["last_name"]
          request.address.address = payment_params[:shipping_street1]
          request.address.city = payment_params[:shipping_city]
          request.address.state = payment_params[:shipping_state]
          request.address.zip = payment_params[:shipping_zipcode]
          request.customerProfileId = profile_id
          # Create Shipping
          response = transaction.create_customer_shipping_profile(request)

          if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
            return response.customerAddressId
          else
            raise ArgumentError, "#{response.messages.messages[0].text} -- Failed to create a new customer shipping address."
            return false
          end
        end #END def

        # Create Subscription Payment
        # See user_interface.rb => def create_authnet_accounts(form_data={})
        # See authorize_dot_net.rb => def create_authnet_accounts(form_data={})
        def create_subscription(amount, profile_id, payment_id, shipping_id)
          # Start the Transaction
          transaction = AuthorizeNet::API::Transaction.new(ENV['AUTHORIZE_NET_KEY'], ENV['AUTHORIZE_NET_SECRET'], {gateway: ENV['AUTHORIZE_NET_ENV'].to_sym})
          request = AuthorizeNet::API::ARBCreateSubscriptionRequest.new
          request.refId = DateTime.now.to_s[-8]
          request.subscription = AuthorizeNet::API::ARBSubscriptionType.new
          request.subscription.name = "#{@knowmadics['first_name']} #{@knowmadics['last_name']}"
          request.subscription.paymentSchedule = AuthorizeNet::API::PaymentScheduleType.new
          request.subscription.paymentSchedule.interval = AuthorizeNet::API::PaymentScheduleType::Interval.new("1","months")
          request.subscription.paymentSchedule.startDate = (DateTime.now).to_s[0...10]
          request.subscription.paymentSchedule.totalOccurrences = '12'
          request.subscription.paymentSchedule.trialOccurrences = '1'
          request.subscription.amount = amount
          request.subscription.trialAmount = 0.00

          request.subscription.profile = AuthorizeNet::API::CustomerProfileIdType.new
          request.subscription.profile.customerProfileId = profile_id
          request.subscription.profile.customerPaymentProfileId = payment_id
          request.subscription.profile.customerAddressId = shipping_id

          response = transaction.create_subscription(request)

          if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
            return response.subscriptionId
          else
            raise ArgumentError, "#{response.messages.messages[0].text} -- Code: #{response.messages.messages[0].code} -- Failed to create a subscription"
            return false
          end
        end #END def

        # Create Pre Authorization
        # Requires Knowmadics Data
        # u = UserInterface.new user_id: ENV['KNOWMADICS_USERID']
        # u.open_pre_authorization('10.00', u.knowmadics)
        def open_pre_authorization(amount, knowmadics_data={})
          # Start the Pre-Authorization
          transaction = AuthorizeNet::API::Transaction.new(ENV['AUTHORIZE_NET_KEY'], ENV['AUTHORIZE_NET_SECRET'], {gateway: ENV['AUTHORIZE_NET_ENV'].to_sym})

          request = AuthorizeNet::API::CreateTransactionRequest.new

          request.transactionRequest = AuthorizeNet::API::TransactionRequestType.new()
          request.transactionRequest.amount = amount
          request.transactionRequest.profile = AuthorizeNet::API::CustomerProfile::PaymentType.new
          request.transactionRequest.profile.customerProfileId = knowmadics_data['customerProfileId']
          request.transactionRequest.profile.paymentProfile = AuthorizeNet::API::PaymentProfile.new knowmadics_data['paymentProfileId']
          request.transactionRequest.transactionType = AuthorizeNet::API::TransactionTypeEnum::AuthCaptureTransaction

          response = transaction.create_transaction(request)

          if response.messages.resultCode == ::MessageTypeEnum::Ok
            puts "Successful charge (auth + capture) (authorization code: #{response.transactionResponse.authCode})"
          else
            raise ArgumentError, "#{response.messages.messages[0].text} -- Code: #{response.transactionResponse.errors.errors[0].errorCode} -- #{response.transactionResponse.errors.errors[0].errorText}Failed to charge card."
          end

          return response
        end #END def

        # Create Transaction from Pre Authorization
        # Requires Knowmadics Data
        # u = UserInterface.new user_id: ENV['KNOWMADICS_USERID']
        # u.open_pre_authorization('10.00', u.knowmadics)
        def close_pre_authorization(amount, knowmadics_data={}, authorization_id)
          # Start the Transaction
          transaction = AuthorizeNet::API::Transaction.new(ENV['AUTHORIZE_NET_KEY'], ENV['AUTHORIZE_NET_SECRET'], {gateway: ENV['AUTHORIZE_NET_ENV'].to_sym})

          request = AuthorizeNet::API::CreateTransactionRequest.new

          request.transactionRequest = AuthorizeNet::API::TransactionRequestType.new()
          request.transactionRequest.amount = amount
          request.transactionRequest.profile = AuthorizeNet::API::CustomerProfile::PaymentType.new
          request.transactionRequest.profile.customerProfileId = knowmadics_data['customerProfileId']
          request.transactionRequest.profile.paymentProfile = AuthorizeNet::API::PaymentProfile.new knowmadics_data['paymentProfileId']
          request.transactionRequest.transactionType = AuthorizeNet::API::TransactionTypeEnum::AuthCaptureTransaction

          response = transaction.create_transaction(request)

          if response != nil
            if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
              if response.transactionResponse != nil && response.transactionResponse.messages != nil
                puts "Successful charge (auth + capture) (authorization code: #{response.transactionResponse.authCode})"
                puts "Transaction Response code : #{response.transactionResponse.responseCode}"
                puts "Code : #{response.transactionResponse.messages.messages[0].code}"
                puts "Description : #{response.transactionResponse.messages.messages[0].description}"
              else
                puts "Transaction Failed"
                if response.transactionResponse.errors != nil
                  puts "Error Code : #{response.transactionResponse.errors.errors[0].errorCode}"
                  puts "Error Message : #{response.transactionResponse.errors.errors[0].errorText}"
                end
                raise ArgumentError, "Failed to charge card."
              end
            else
              puts "Transaction Failed"
              if response.transactionResponse != nil && response.transactionResponse.errors != nil
                puts "Error Code : #{response.transactionResponse.errors.errors[0].errorCode}"
                puts "Error Message : #{response.transactionResponse.errors.errors[0].errorText}"
              else
                puts "Error Code : #{response.messages.messages[0].code}"
                puts "Error Message : #{response.messages.messages[0].text}"
              end
              raise ArgumentError, "Failed to charge card."
            end
          else
            puts "Response is null"
            raise ArgumentError, "Failed to charge card."
          end

          return response
        end #END def

        # Create a Transaction from a Credit Card or User Account
        # Requires Knowmadics Data
        # u = UserInterface.new user_id: ENV['KNOWMADICS_USERID']
        # u.create_transaction('10.00', u.knowmadics)
        # OR
        # form_data = { cc_number: '4242424242424242', cc_exp: '0220', cc_cvv: '123', email: 'bmc@mail.com' }
        # AuthorizeDotNet.create_transaction('10.00', form_data, true)
        def AuthorizeDotNet.create_transaction(amount, knowmadics_data={}, guest_checkout=false)
          transaction = AuthorizeNet::API::Transaction.new(ENV['AUTHORIZE_NET_KEY'], ENV['AUTHORIZE_NET_SECRET'], {gateway: ENV['AUTHORIZE_NET_ENV'].to_sym})

          request = AuthorizeNet::API::CreateTransactionRequest.new

          request.transactionRequest = AuthorizeNet::API::TransactionRequestType.new()
          request.transactionRequest.amount = amount

          # Charge a card or a user account
          if guest_checkout
            request.transactionRequest.payment = AuthorizeNet::API::PaymentType.new
            request.transactionRequest.payment.creditCard = AuthorizeNet::API::CreditCardType.new(knowmadics_data[:cc_number], knowmadics_data[:cc_exp], knowmadics_data[:cc_cvv])
            request.transactionRequest.customer = AuthorizeNet::API::CustomerType.new(nil, knowmadics_data[:email])
          else
            request.transactionRequest.profile = AuthorizeNet::API::CustomerProfile::PaymentType.new
            request.transactionRequest.profile.customerProfileId = knowmadics_data['customerProfileId']
            request.transactionRequest.profile.paymentProfile = AuthorizeNet::API::PaymentProfile.new knowmadics_data['paymentProfileId']
          end

          request.transactionRequest.transactionType = AuthorizeNet::API::TransactionTypeEnum::AuthCaptureTransaction
          response = transaction.create_transaction(request)

          if response != nil
            if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
              if response.transactionResponse != nil && response.transactionResponse.messages != nil
                puts "Successful charge (auth + capture) (authorization code: #{response.transactionResponse.authCode})"
                puts "Transaction Response code : #{response.transactionResponse.responseCode}"
                puts "Code : #{response.transactionResponse.messages.messages[0].code}"
                puts "Description : #{response.transactionResponse.messages.messages[0].description}"
              else
                puts "Transaction Failed"
                if response.transactionResponse.errors != nil
                  puts "Error Code : #{response.transactionResponse.errors.errors[0].errorCode}"
                  puts "Error Message : #{response.transactionResponse.errors.errors[0].errorText}"
                end
                raise "Failed to charge card."
              end
            else
              puts "Transaction Failed"
              if response.transactionResponse != nil && response.transactionResponse.errors != nil
                puts "Error Code : #{response.transactionResponse.errors.errors[0].errorCode}"
                puts "Error Message : #{response.transactionResponse.errors.errors[0].errorText}"
              else
                puts "Error Code : #{response.messages.messages[0].code}"
                puts "Error Message : #{response.messages.messages[0].text}"
              end
              raise "Failed to charge card."
            end
          else
            puts "Response is null"
            raise "Failed to charge card."
          end

          return response
        end #END def

    end #END class_methods

end #END class
