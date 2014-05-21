# pair-programmed w/Zak A.

require 'sinatra'
require 'csv'
require 'uri'

get '/' do

  team_array = []

  CSV.foreach('lackp_starting_rosters.csv', headers: true) do |row|
    team_array << row.to_hash
  end


  team_names = []

  team_array.each do |row|

    team_names.push(row["team"])

  end

  team_names.uniq!

  @teams = team_names
  erb :index
end

get '/:team' do

  team_array = []

  CSV.foreach('lackp_starting_rosters.csv', headers: true, header_converters: :symbol) do |row|
    team_array << row.to_hash
  end

  @teams = team_array

  @teams = @teams.find_all do |t|
    t[:team] == params[:team]
  end

  erb :show
end

# These lines can be removed since they are using the default values. They've
# been included to explicitly show the configuration options.
set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'
