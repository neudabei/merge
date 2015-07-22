class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You have to log in to perform this action."
      redirect_to root_path
    end
  end

  def merge_csvs(path_to_folder)

    require 'csv'

    master = CSV.read("#{path_to_folder}/master.csv") # Reads in master # -> datei.csv.current_path didn't get the actual file
    master.each {|each| each.push('')} # Adds another column to all rows
    Dir.glob("#{path_to_folder}/*.csv").each do |each| #Goes thru all csv files
      next if each == 'master.csv' # skips the master csv file
      file = CSV.read(each) # Reads in each file
      file.each do |line| #Goes thru each line of the file
        temp = master.assoc(line[0]) # Finds the appropriate line in master
        temp[-1] = line[1] if temp #updates last column if line is found
      end
    end

    csv = CSV.open("#{path_to_folder}/output.csv",'wb') #opens output csv file for writing
    master.each {|each| csv << each} #Goes thru modified master and saves it to file
    csv.close
  end

end
