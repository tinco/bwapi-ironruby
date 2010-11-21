require 'bwapi'

class BwapiRuby
	include BWAPI
	def self.connect
		puts "Trying to connect"
		while(!Bwapi.BWAPIClient.connect) do
			sleep 1
			puts "Retrying.."
		end
		puts "Connected"
	end

	def self.run(bot)
		puts "IronRuby BWAPI Client"
		client = Bwapi.BWAPIClient
		Bwapi.BWAPI_init
		puts "Waiting for match"

		connect

		while(!Bwapi.Broodwar.isInGame) do
			client.update
			if !client.isConnected
				puts "Disconnected"
				connect
			end
		end

		while true do
			puts "In a match!"
			while(Bwapi.Broodwar.isInGame) do
				Bwapi.Broodwar.getEvents.each do |e|
					case e.type
					when EventType_Enum.MatchStart
						bot.on_start
						break
					when EventType_Enum.MatchEnd
						bot.on_end(e.isWinner)
						break
					when EventType_Enum.MatchFrame
						bot.on_frame
						break
					when EventType_Enum.MenuFrame
						break
					when EventType_Enum.SendText
						bot.on_send_text(e.text)
						break
					when EventType_Enum.ReceiveText
						bot.on_receive_text(e.player, e.text)
						break
					when EventType_Enum.PlayerLeft
						bot.on_player_left(e.player)
						break
					when EventType_Enum.NukeDetect
						bot.on_nuke_detect(e.position)
						break
					when EventType_Enum.UnitDiscover
						bot.on_unit_discover(e.unit)
						break
					when EventType_Enum.UnitEvade
						bot.on_unit_evade(e.unit)
						break
					when EventType_Enum.UnitShow
						bot.on_unit_show(e.unit)
						break
					when EventType_Enum.UnitHide
						bot.on_unit_hide(e.unit)
						break
					when EventType_Enum.UnitCreate
						bot.on_unit_create(e.unit)
						break
					when EventType_Enum.UnitDestroy
						bot.on_unit_destroy(e.unit)
						break
					when EventType_Enum.UnitMorph
						bot.on_unit_morph(e.unit)
						break
					when EventType_Enum.UnitRenegade
						bot.on_unit_renegade(e.unit)
					break
					when EventType_Enum.SaveGame
						bot.on_save_game(e.text)
						break
					else
						break
					end
				end # events.each
				client.update
				if !client.isConnected
					puts "Reconnecting"
					reconnect
				end
			end #while ingame?
		end #while true
	end #run
end #BwapiRuby
