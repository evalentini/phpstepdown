class SessionsController < ApplicationController

  skip_before_filter :confirm_gate, :only => :gate

  def gate
    @curpg = :loginout
    if params[:accesscode].present?
      session[:accesscode]=params[:accesscode]
      session[:adminpassword]=params[:adminpassword]
      session[:usertype]=params[:usertype]
      session[:locfilter]=params[:locfilter].to_i
      if Digest::SHA2.hexdigest(params[:accesscode].to_s)==ENV['GATE_PASS_HASH'].to_s
        #check admin password if necessary 
        if params[:usertype]=="admin" && Digest::SHA2.hexdigest(params[:adminpassword].to_s)!=ENV['ADMIN_PASS_HASH'].to_s
          flash.now[:danger]="Wrong Administrator Password"
          render 'gate'
        else
          flash.now[:success]="Thank You For Logging In"
          redirect_to root_path
        end
      else 
        flash.now[:danger]="Wrong Access Code"
        render 'gate'
      end
    else
      session[:accesscode]=nil
      render 'gate'
    end
  end
  
  def destroy
    session[:accesscode]=nil
    session[:usertype] = nil
    session[:adminpassword]=nil
    redirect_to root_url, :notice => "Logged out"
  end 
  


end
