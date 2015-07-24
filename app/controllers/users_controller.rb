class UsersController < ApplicationController

  before_action :require_same_user, except: [:create, :new, :help, :show]

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
      flash[:notice] = "Your files have been merged!"
      redirect_to show_path 

    else
      render :new
    end

    #merge method from application_controller.rb
    merge_csvs("#{Rails.root}/public/uploads/spreadsheet/csv/#{@user.spreadsheets.first.user_id}")

  end

  def help
  end

  def user_params
    params.require(:user).permit(:email, :password, spreadsheets_attributes: [:id, :user_id, :csv])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "You are not allowed to perform this action"
      redirect_to root_path
    end
  end

end