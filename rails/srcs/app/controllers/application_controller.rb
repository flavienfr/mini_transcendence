class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        puts "-----------hey-----------"
        # if cookies.signed[:id]
        # if 3
        if cookies.signed[:id]
            puts "A-------"
            # cookies.permanent.signed[:id] = 3#enregistre le id
            @current_user ||= User.find(cookies.signed[:id])
            #il faudra rajouter un moyen pour logout quand session plus valide timeout ? meme si c est pas grave
        else
            puts "B-------"
            @current_user = nil
        end
    end
end
