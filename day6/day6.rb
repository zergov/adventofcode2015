lights = []
1000.times do |row|
  lights << []
  1000.times do |col|
    lights[row] << 0
  end
end

File.read('input').lines.each do |line|
  line = line.chomp

  point_a, point_b = line.scan(/\d*,\d*/)
    .map { |coords| coords.split(',').map(&:to_i) }

  xa, ya = point_a
  xb, yb = point_b

  for y in ya..yb do
    for x in xa..xb do
      if line.include?("turn on")
        lights[y][x] += 1
      elsif line.include?("turn off")
        lights[y][x] -= 1 if lights[y][x] > 0
      elsif line.include?("toggle")
        lights[y][x] += 2
      end
    end
  end
end

p lights.flatten.sum
