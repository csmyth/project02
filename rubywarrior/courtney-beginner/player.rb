class Player
  def play_turn(warrior)
	if @health == nil
		@health = warrior.health
	end
	if warrior.feel.empty? && warrior.health < @health
		warrior.walk!
	elsif warrior.feel.empty?
		if warrior.health < 20
			warrior.rest!
		else
			warrior.walk!
		end
	elsif warrior.feel.captive?
		warrior.rescue!
	else
		warrior.attack!
	end
	@health = warrior.health
  end
end
