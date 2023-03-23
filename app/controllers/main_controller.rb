class MainController < ApplicationController
    def index
        if Current.user
            redirect_to new_url_creation_path
        end
    end

    def error
    end
end