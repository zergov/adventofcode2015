weapons = [
    (8, 4, 0),
    (10, 5, 0),
    (25, 6, 0),
    (40, 7, 0),
    (74, 8, 0),
]

armors = [
    (0, 0, 0),
    (13, 0, 1),
    (31, 0, 2),
    (53, 0, 3),
    (75, 0, 4),
    (102, 0, 5),
]

rings = [
    (0, 0, 0),
    (25, 1, 0),
    (50, 2, 0),
    (100, 3, 0),
    (20, 0, 1),
    (40, 0, 2),
    (80, 0, 3),
]

def simulate(hp, armor, damage):
    boss_hp = 109
    boss_damage = 8
    boss_armor = 2

    while True:
        boss_hp -= max(damage - boss_armor, 1)
        if boss_hp <= 0:
            return True

        hp -= max(boss_damage - armor, 1)
        if hp <= 0:
            return False


part1 = 10000000000000000
part2 = -10000000000000000
for weapon in weapons:
    for armor in armors:
        for ring1 in rings:
            for ring2 in rings:
                if ring1 == ring2 and ring1 is not (0, 0, 0):
                    continue

                cost = weapon[0] + armor[0] + ring1[0] + ring2[0]
                damage_value = weapon[1] + armor[1] + ring1[1] + ring2[1]
                armor_value = weapon[2] + armor[2] + ring1[2] + ring2[2]

                if simulate(100, armor_value, damage_value):
                    part1 = min(part1, cost)
                else:
                    part2 = max(part2, cost)

print(part1)
print(part2)
