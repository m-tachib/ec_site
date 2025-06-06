class ApplicationController < ActionController::Base
    # ログイン後の遷移先を設定
    def after_sign_in_path_for(resource)
        case resource
        when Admin
            books_path
        when User
            mypage_path(resource)
        end
    end

    # ログアウト後の遷移先を設定
    def after_sign_out_path_for(resource)
        root_path
    end
end

