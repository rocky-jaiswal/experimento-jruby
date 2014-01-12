class PagesController < ApplicationController
  
  def login
    redirect_to home_path if user_signed_in?
  end

  def home
  end

  def work
    #TimeConsumingWorker.perform_async('Worker-1', 100)
    #BigSupervisor.perform_async
    #supervisor = BigSupervisor.new
    #Celluloid::Actor[:supervisor] = supervisor
    #Celluloid::Actor[:supervisor].async.work
    BigSupervisor.new.async.work
    
    render :json => {success: true}.as_json
  end

end
