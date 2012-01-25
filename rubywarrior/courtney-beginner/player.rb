class Player
  def play_turn(warrior)
	if @prev_health == nil
		@prev_health = warrior.health
		@wall_found = false
	end
	
	if warrior.feel(:backward).wall?
		@wall_found = true
	end
	
	
	if warrior.feel(:backward).empty? && @wall_found != true 
		warrior.walk!(:backward)
		
	elsif warrior.feel(:backward).captive?
			warrior.rescue!(:backward)
	elsif warrior.feel.captive?
		warrior.rescue!
	
	elsif warrior.feel(:backward).enemy?
			warrior.attack!(:backward)
	
	elsif warrior.feel.empty? && warrior.health < @prev_health
		warrior.walk!
	elsif warrior.feel.empty?
		if warrior.health < 20
			warrior.rest!
		else
			warrior.walk!
		end
	else
		warrior.attack!
	end
	@prev_health = warrior.health
  end
end
