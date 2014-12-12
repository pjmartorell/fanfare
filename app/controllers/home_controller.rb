class HomeController < ApplicationController
  before_filter :to_events_path, only: :index

  def error_404
    respond_to do |format|
      format.html   { render :layout => false, :status => 404 }
      format.all    { render :nothing => true, :status => 404 }
    end
  end

  private

  def to_events_path
    if current_user
      redirect_to bands_path(with_parameters) and return
    end
  end

  def with_parameters
    request.parameters.reject {|item| ["action", "controller"].include? item }
  end
end
