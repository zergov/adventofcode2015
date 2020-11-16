reins = []

File.read('input').lines do |line|
  parts = line.chomp.split

  name = parts[0]
  speed = parts[3]
  duration = parts[6]
  sleep = parts[13]

  reins << {
    name: name,
    points: 0,
    state: :running,
    running_t: 0,
    sleeping_t: 0,
    distance: 0,
    speed: speed.to_i,
    duration: duration.to_i,
    sleep: sleep.to_i,
  }
end

2503.times do
  reins.each do |rein|
    speed = rein[:speed]
    duration = rein[:duration]
    sleep = rein[:sleep]
    state = rein[:state]

    if state == :running
      rein[:distance] += speed
      rein[:running_t] += 1

      if rein[:running_t] == duration
        rein[:state] = :sleeping
        rein[:running_t] = 0
      end
    elsif state == :sleeping
      rein[:sleeping_t] += 1

      if rein[:sleeping_t] == sleep
        rein[:state] = :running
        rein[:sleeping_t] = 0
      end
    end
  end

  max_distance = reins
    .map { |rein| rein[:distance] }
    .max

  winners = reins.select { |rein| rein[:distance] == max_distance }
  winners.each { |rein| rein[:points] += 1 }
end

p reins.map { |rein| rein[:points] }.max
