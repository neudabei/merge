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

      # uploaded_io = params[:user][:filename]
      # File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
      #   file.write(uploaded_io.read)
      # end


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
  end

  def merge

    require 'csv'
    master = CSV.read('uploads/spreadsheet/csv/24/master.csv') # Reads in master
    master.each {|each| each.push('')} # Adds another column to all rows
    Dir.glob('uploads/spreadsheet/csv/24/*.csv').each do |each| #Goes thru all csv files
      next if each == 'master.csv' # skips the master csv file
      file = CSV.read(each) # Reads in each one
      file.each do |line| #Goes thru each line of the file
        temp = master.assoc(line[0]) # Finds the appropriate line in master
        temp[-1] = line[1] if temp #updates last column if line is found
      end
    end

    csv = CSV.open('output.csv','wb') #opens output csv file for writing
    master.each {|each| csv << each} #Goes thru modified master and saves it to file

  end

  def user_params
    params.require(:user).permit(:email, :password, spreadsheets_attributes: [:id, :user_id, :csv])
  end

end