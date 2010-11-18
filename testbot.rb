require 'bwapi-clr'

puts "IronRuby BWAPI Client"
bwapi = BWAPI::Bwapi
client = bwapi.BWAPIClient
bwapi.BWAPI_init

puts "Trying to connect"
while(!client.connect) do
  sleep 1
  puts "Retrying.."
end

puts "Connected, waiting for match"

while(!bwapi.Broodwar.isInGame) do
  client.update
  if !client.isConnected
    puts "Disconnected"
    exit
  end
end

puts "In a match!"
bwapi.Broodwar.sendText "Hello Starcraft from IronRuby!"
