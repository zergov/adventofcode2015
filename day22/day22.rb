$min_mana = 100000000000000000000000
$part2 = true

def simulate(
  mana_spent,

  shield,
  poisoned,
  recharging,

  mana,
  hp,

  boss_hp,

  player_turn
)
  return if mana_spent >= $min_mana

  if $part2 && player_turn
    hp -= 1
  end

  return if hp <= 0

  boss_hp -= 3 if poisoned > 0
  mana += 101 if recharging > 0
  armor = shield > 0 ? 7 : 0

  shield = [shield - 1, 0].max
  poisoned = [poisoned - 1, 0].max
  recharging = [recharging - 1, 0].max

  if boss_hp <= 0
    $min_mana = [$min_mana, mana_spent].min
    return
  end

  return if mana < 53 # cannot cast any spell

  if player_turn
    # magic missile
    if mana >= 53
      simulate(mana_spent + 53, shield, poisoned, recharging, mana - 53, hp, boss_hp - 4, false)
    end

    # drain
    if mana >= 73
      simulate(mana_spent + 73, shield, poisoned, recharging, mana - 73, hp + 2, boss_hp - 2, false)
    end

    # shield
    if mana >= 113 && shield == 0
      simulate(mana_spent + 113, 6, poisoned, recharging, mana - 113, hp, boss_hp, false)
    end

    # poison
    if mana >= 173 && poisoned == 0
      simulate(mana_spent + 173, shield, 6, recharging, mana - 173, hp, boss_hp, false)
    end

    # recharge
    if mana >= 229 && recharging == 0
      simulate(mana_spent + 229, shield, poisoned, 5, mana - 229, hp, boss_hp, false)
    end
  else
    damage = [9 - armor, 1].max # boss damage
    simulate(mana_spent, shield, poisoned, recharging, mana, hp - damage, boss_hp, true)
  end
end

simulate(0, 0, 0, 0, 500, 50, 51, true)

p $min_mana
