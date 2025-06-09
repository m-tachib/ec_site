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

def current_cart
    @current_cart = Cart.find_by(id: session[:cart_id])
    @current_cart = Cart.create unless @current_cart
    session[:cart_id] = @current_cart.id
    @current_cart
end
