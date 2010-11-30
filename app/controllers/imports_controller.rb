class ImportsController < ApplicationController
  include GmailImport

  before_filter :authenticate_user!
  respond_to :html

  def show
  end

  def create
    import_module_name = params[:import_type].classify.constantize
    file = params[:import][:upload]

    import_module_name::import!(file)
    flash[:notice] = "Import successfull"
    render :action => :new

    rescue StandardError => e
      flash[:error] = "Something went wrong: #{e.message}. Fill the feedback form, please."
      render :action => :new
  end

end
