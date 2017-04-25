class Api::FirstAdvantageController < ApplicationController

    layout false
    respond_to :xml
    skip_before_filter :verify_authenticity_token, only: [:candidate_invitation_status_callback]

    # Handle Candidate Invitation Status Updates
    # Final:
    # <Quoteback name="ApplicantId">S5THCLG5EC</Quoteback>
    # <OrderStatus>InProgress</OrderStatus> (there are multiple, this one is the first one)
    def candidate_invitation_status_callback
        data = ::Nokogiri::XML request.body.string

        user_id = data.css("Quotebacks Quoteback").last.text  rescue nil
        application_status = data.css("BackgroundReportPackage ScreeningStatus OrderStatus").first.text  rescue nil
        final_status = data.css("ScreeningStatus Score").first.text rescue nil

        # If true, it is the application final status,
        # otherwise it is them just going through the forms
        if final_status
            # Final Call
            user_id # Knowmadics Base64 ID
            final_status # Did it flag?
                # final_status:
                # Eligible    (Order has been received, processed and completed.  No derogatory information was found.)
                # Decisional   (Order has been received, processed and completed; however a review is required.)
                # Ineligible   (Order has been received, processed and completed; derogatory information was found. )
        elsif user_id && application_status
            user_id # Knowmadics Base64 ID
            application_status # InProgress
        else
            application_event = data.css('ApplicationEvent').first.text     rescue nil
            application_status = data.css('ApplicationStatus').first.text   rescue nil
            application_id = data.css('ApplicantId').first.text             rescue nil
                #  [application_event]       |   [application_status]     |   [application_id]
                # "Application Created"     |      "Not Started"        |    "WTLD3TPC4J"
                # "Consent Accepted"        |        "Started"          |    "WTLD3TPC4J"
                # "Application Submitted"   |        "Completed"        |    "WTLD3TPC4J"
        end

        render xml: 'Hello', status: 200
    end

end
