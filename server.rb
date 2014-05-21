# pair-programmed w/Zak A.

require 'sinatra'
require 'csv'
require 'uri'

def get_rosters

  team_array = []

  CSV.foreach('lackp_starting_rosters.csv', headers: true, header_converters: :symbol) do |row|
    team_array << row.to_hash
  end

  team_array

end

get '/' do

  team_array = get_rosters

  team_names = []
  pos_names = []

  team_array.each do |row|

    team_names.push(row[:team])
    pos_names.push(row[:position])

  end

  team_names.uniq!
  pos_names.uniq!

  @teams = team_names
  @positions = pos_names
  erb :index

end

get '/:team' do

  @teams = get_rosters

  @teams = @teams.find_all do |t|
    t[:team] == params[:team]
  end

  erb :show

end

get '/pos/:position' do

  @teams = get_rosters

  @teams = @teams.find_all do |t|
    t[:position] == params[:position]
  end

  erb :'pos/show'

end
