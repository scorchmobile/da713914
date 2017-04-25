class ApplicationController < AuthenticationController

    protect_from_forgery with: :exception

end
