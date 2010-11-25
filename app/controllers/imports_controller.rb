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
    # import = import_class_name.constantize.new(
    #   :account => Context.account,
    #   :user => Context.user,
    #   :data_to_import => params[:import][:upload].read)
    #   
    # Transaction.transaction do
    #   import.import!
    #   render :action => :new
    #   end
    render :action => :new
  end

end
