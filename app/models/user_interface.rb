class UserInterface

    # Load Modules
    include FirstAdvantage
    include Knowmadics
    include AuthorizeDotNet

    # Class Attributes
    attr_accessor :user_id, :api_key, :first_advantage, :knowmadics, :authorize_net

    # Pass in a user_id: VALUE and load the user object
    # u = UserInterface.new user_id: ENV['KNOWMADICS_USERID']
    # OR
    # user_data = { email: 'random@test.com', first_name: 'Test', last_name: 'Test', middle_name: 'Test', username: 'random@test.com', password: 'testtest' }
    # u = UserInterface.new create: true, user: user_data
    def initialize(options={})
        # Setup to handle the creation of the object if an ID is unknown
        @api_key = ENV['KNOWMADICS_API_KEY']
        @user_id = (options[:user_id] or raise(ArgumentError, "Must specify an user_id: VALUE"))    unless options[:create].present?
        @user_id = Knowmadics.create_user_account options[:user]                                    if options[:create].present?
        self.load_knowmadics_data @user_id
        self.load_first_advantge_data(@knowmadics) || {}
        self.load_authortize_net_data(@knowmadics) || {}
    end #END def

    # Have a way of creating the user and the returning the whole object
    # Expects :email, :first_name, :last_name , :middle_name, :username (email), :password (min length 8)
    # form_data = { email: 'random@test.com', first_name: 'Test', last_name: 'Test', middle_name: 'Test', username: 'random@test.com', password: 'testtest' }
    # u = UserInterface.create form_data
    def self.create(form_data={})
        user_id = Knowmadics.create_user_account form_data
        return UserInterface.new(user_id: user_id)
    end #END def

    # Create AuthNet Profiles from Form Data POST, Requires a Valid Knowmadics UserInterface Object
    # u = UserInterface.new user_id: ENV['KNOWMADICS_USERID']
    # form_data = { user_type_id: 6, cc_number: '4111111111111111', cc_year: '2019', cc_month: '12', cc_cvv: '123', user_id: @user_id, billing_street1: '123 Main', billing_street2: 'unit 1', billing_city: 'dallas', billing_state: 'texas', billing_zipcode: '75230', shipping_street1: '123 Main', shipping_street2: 'unit 1', shipping_city: 'dallas', shipping_state: 'texas', shipping_zipcode: '75230' }
    # u.create_authnet_accounts
    def create_authnet_accounts(form_data={})
        @authorize_net = self.class.create_authortize_net_profiles(form_data)
        @knowmadics["userTypeId"] =             @authorize_net["user_type_id"]
        @knowmadics["customerProfileId"] =      @authorize_net["profile_id"]
        @knowmadics["addressProfileId"] =       @authorize_net["address_id"]
        @knowmadics["paymentProfileId"] =       @authorize_net["payment_id"]
        @knowmadics["subscriptionProfileId"] =  @authorize_net["subscription_id"]
        @knowmadics["subscriptionValid"] =      "True"
        @knowmadics["subscriptionExpiryDate"] = (DateTime.now + 1.year).strftime("%Y-%m-%d %H:%M:%S")

        # Update the Information
        self.update!
        return self
    end #END def

end #END class
