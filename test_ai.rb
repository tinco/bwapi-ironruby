require 'bwapi-ironruby'

class TestAI
  def on_start
    puts "Match started"
    starcraft = BWAPI::Bwapi.Broodwar
    player = starcraft.self
    units = player.getUnits

    #send each worker to the mineral field that is closest to it
    units.select {|u| u.getType.isWorker}.each do |w|
      closest_mineral = nil
      starcraft.getMinerals.each do |m|
        if closest_mineral.nil? || w.getDistance(m) < w.getDistance(closest_mineral)
          closest_mineral= m
        end
      end
      w.rightClick(closest_mineral)
    end

    center = units.select{|u|u.getType.isResourceDepot}.first
    return unless center
    puts "found a center"
    #if this is a center, tell it to build the appropiate type of worker
    if center.getType.getRace != BWAPI::Bwapi.Races_Zerg
      puts "training at center"
      center.train(starcraft.self.getRace.getWorker)
    else
      center.getLarva.first do |l|
        puts "spawning from larva"
        l.morph(BWAPI::Bwapi.UnitTypes_Zerg_Drone)
      end
    end
  end

  def on_frame

  end

  def method_missing(name, *arguments)
    #ignore for now
  end
end

BwapiRuby.run TestAI.new
