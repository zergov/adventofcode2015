houses = {}

santa_position = [0, 0]
robot_position = [0, 0]

File.read('input').chomp.chars.each.with_index do |direction, i|
  position = i.odd? ? santa_position : robot_position

  if houses.key?(position)
    houses[position] += 1
  else
    houses[position] = 1
  end

  x, y = position

  case direction
  when '^'
    position = [x, y + 1]
  when '<'
    position = [x - 1, y]
  when '>'
    position = [x + 1, y]
  when 'v'
    position = [x, y - 1]
  end

  if i.odd?
    santa_position = position
  else
    robot_position = position
  end
end

p houses.keys.size
