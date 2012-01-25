class Player
  def play_turn(warrior)
	#Initialize instance variables
	if @prev_health == nil
		@prev_health = warrior.health
		@wall_found = false
		@close_enemy = true
		@need_rest = false
	end
	
	#Senses Evaluation
	if warrior.feel(:backward).wall?
		@wall_found = true
	end
	if warrior.feel.empty? && warrior.health < @prev_health
		@close_enemy = false
	else
		@close_enemy = true
	end
	
	#Conditional Actions
	if @need_rest
		if warrior.health < 20
			warrior.rest!
		else 
			@need_rest = false
			warrior.walk!
		end
		
	elsif warrior.feel(:backward).empty? && !(@wall_found)
		warrior.walk!(:backward)
		
	elsif warrior.feel(:backward).captive?
		warrior.rescue!(:backward)
	elsif warrior.feel.captive?
		warrior.rescue!
	
	elsif warrior.feel(:backward).enemy?
		warrior.attack!(:backward)
	
	elsif !(@close_enemy)
		warrior.walk!
	elsif @close_enemy && warrior.health < 15
		@need_rest = true
		warrior.walk!(:backward)
	
	elsif warrior.feel.empty?
		if warrior.health < 20
			warrior.rest!
		else
			warrior.walk!
		end
	else
		warrior.attack!
	end
	
	#Record health
	@prev_health = warrior.health
  end
end
