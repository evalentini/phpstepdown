class ApplicationController < ActionController::Base
  
  layout "main"
  
  protect_from_forgery
  
  before_filter :confirm_gate
  
  def confirm_gate
    if session[:accesscode].present? 
      unless session[:accesscode].nil?
        if Digest::SHA2.hexdigest(session[:accesscode].to_s)==ENV['GATE_PASS_HASH'].to_s
        else
          redirect_to gate_path 
        end
      else
        redirect_to gate_path
      end
    else
      redirect_to gate_path
    end
  end
  
  
end
