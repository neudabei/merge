class UsersController < ApplicationController

  before_action :require_user, except: [:create, :new]

  def show
    @user = current_user
  end

  def new
    @user = User.new
    @spreadsheet = @user.spreadsheets.build
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      params[:spreadsheets]['csv'].each do |c|
        @spreadsheet = @user.spreadsheets.create(:csv => c)
      end
      flash[:notice] = "You are registered."
      redirect_to upload_path 

    else
      render :new
    end

    #merge method from application_controller.rb
    merge_csvs("#{Rails.root}/public/uploads/spreadsheet/csv/#{@user.spreadsheets.first.user_id}")

  end

  def user_params
    params.require(:user).permit(:email, :password, spreadsheets_attributes: [:id, :user_id, :csv])
  end

end