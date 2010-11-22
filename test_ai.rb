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

    <<-TODO
      	 else if ((*i)->getType().isResourceDepot())
        {
          //if this is a center, tell it to build the appropiate type of worker
          if ((*i)->getType().getRace()!=Races::Zerg)
          {
            (*i)->train(Broodwar->self()->getRace().getWorker());
          }
          else //if we are Zerg, we need to select a larva and morph it into a drone
          {
            std::set<Unit*> myLarva=(*i)->getLarva();
            if (myLarva.size()>0)
            {
              Unit* larva=*myLarva.begin();
              larva->morph(UnitTypes::Zerg_Drone);
            }
       TODO
	end

	def on_frame
		
	end

	def method_missing(name, *arguments)
		#ignore for now
	end
end

BwapiRuby.run TestAI.new
