require 'active_support/concern'
require 'httparty'
require 'builder'
require 'securerandom'

module FirstAdvantage

    # Model Extension
    extend ActiveSupport::Concern

    included do
        # scope :example, -> { where(disabled: true) }
        # has_many :taggings, as: :taggable
        # has_many :tags, through: :taggings
        class_attribute :user_id, :api_key, :first_advantage, :knowmadics, :authorize_net

               # Load the data
        def load_first_advantge_data(knowmadics_data={})
            @first_advantge_data = { "applicant_id" => knowmadics_data["applicationId"] }
            return @first_advantge_data
        end

        # Send the Background Screening Invitation
        # u = UserInterface.new user_id: ENV['KNOWMADICS_USERID']
        # u.send_candidate_invitation
        def send_candidate_invitation
            # Build XML API Call
            # Endpoint: https://enterprise.fadv.com/pub/xchange/ws/candidateService?wsdl
            xml = ::Builder::XmlMarkup.new
            # Hack to remove the outer <inspect> tags
            def xml.inspect; target!; end
            xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
            xml.CandidateInvitations xmlns: "http://www.cpscreen.com/schemas",
            "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
            userId: ENV['FADV_IT_USER_ID'],
            account: ENV['FADV_IT_ACCOUNT'],
            password: Storage.first.first_adv,
            "xsi:schemaLocation" => "http://www.cpscreen.com/schemas/CandidateInvitations.xsd" do |cis|
                cis.CandidateInvitation do |ci|
                    ci.Quotebacks do |q|
                        q.Quoteback "#{@knowmadics["user_id"]}", name: 'user_id'
                    end #END q
                    ci.CandidateType "PROFILE"
                    ci.PersonalData do |pd|
                        pd.PersonName type: 'subject' do |pn|
                            pn.GivenName @knowmadics['first_name']
                            pn.MiddleName @knowmadics['middle_name']
                            pn.FamilyName @knowmadics['last_name']
                        end #END pn
                        pd.ContactMethod do |cm|
                            cm.InternetEmailAddress @knowmadics['emailAddress']
                        end #END cm
                    end #END pd
                    ci.BackgroundSearchPackageId ENV['FADV_BACKGROUND_SEARCH_PACKAGE_ID']
                end #END ci
            end #END cis
            #p "#{xml.target!}"

            # Get the Call
            response = ::HTTParty.post(ENV['FADV_API_CANDIDATE_INVITATION_URL'], body: "#{xml.target!}", headers: { "Content-Type" => "text/xml;charset=UTF-8" })
            #puts response.body, response.code, response.message, response.headers.inspect

            save_candidate_invitation_id(response.body)
        end #END def

        # Extract the ID and save it
        def save_candidate_invitation_id(xml_response)
            data = ::Nokogiri::XML xml_response
            application_id = data.css("ApplicantId").first.text
            @first_advantge_data["applicant_id"] = application_id
            @knowmadics["applicationId"] = application_id

            # Send to Knowmadics
            self.update!
            return self
        end

    end

    class_methods do

        def FirstAdvantage.update_password
            # Build XML Call
            # Endpoint: https://enterprisetest.fadv.com/pub/xchange/ws/admin?WSDL
            xml = ::Builder::XmlMarkup.new
            def xml.inspect; target!; end
            xml.ChoicePointAdminRequest xmlns: "http://www.cpscreen.com/schemas",
            "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
            "xsi:schemaLocation" => "http://www.cpscreen.com/schemas AdminRequest.xsd",
            userId: ENV['FADV_IT_USER_ID'],
            account: ENV['FADV_IT_ACCOUNT'],
            password: Storage.first.first_adv do |cpar|
                cpar.ChangePassword do |cp|
                    cp.Account ENV['FADV_IT_ACCOUNT']
                    cp.UserId ENV['FADV_IT_USER_ID']
                    cp.Password Storage.first.first_adv
                end
            end
            p xml.target!

            # Get the Call
            response = ::HTTParty.post(ENV['FADV_API_UPDATE_PASSWORD_URL'], body: "#{xml.target!}", headers: { "Content-Type" => "text/xml;charset=UTF-8" })
            #puts response.body, response.code, response.message, response.headers.inspect

            data = ::Nokogiri::XML response.body
            new_password = data.css('NewPassword').first.text  rescuen nil
            Storage.first.update_attribute(:first_adv, new_password) if !new_password.blank?
        end

    end

end
