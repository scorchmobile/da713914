class Devise::Admins::UnlocksController < Devise::UnlocksController
  
  layout 'public'
  
  prepend_before_filter :require_no_authentication

  # GET /resource/unlock/new
  def new
    super
  end

  # POST /resource/unlock
  def create
    super
  end

  # GET /resource/unlock?unlock_token=abcdef
  def show
    super
  end

  protected

    # The path used after sending unlock password instructions
    def after_sending_unlock_instructions_path_for(resource)
      new_session_path(resource) if is_navigational_format?
    end

    # The path used after unlocking the resource
    def after_unlock_path_for(resource)
      new_session_path(resource)  if is_navigational_format?
    end

    def translation_scope
      'devise.unlocks'
    end
end
