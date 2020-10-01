require_relative './config/environment.rb'

app = Cli.new

app.welcome
app.get_player
app.main_menu

