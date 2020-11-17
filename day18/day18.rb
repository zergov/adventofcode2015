def next_state(grid, i, j)
  neighbors = []
  neighbors << grid.dig(i, j + 1)
  neighbors << grid.dig(i, j - 1) if j - 1 >= 0
  neighbors << grid.dig(i - 1, j) if i - 1 >= 0
  neighbors << grid.dig(i + 1, j)
  # diagonals
  neighbors << grid.dig(i - 1, j + 1) if i - 1 >= 0
  neighbors << grid.dig(i + 1, j - 1) if j - 1 >= 0
  neighbors << grid.dig(i - 1, j - 1) if i - 1 >= 0 && j - 1 >= 0
  neighbors << grid.dig(i + 1, j + 1)

  neighbors_on = neighbors.compact.select(&:itself).size

  if grid.dig(i, j)
    neighbors_on == 2 || neighbors_on == 3
  else
    neighbors_on == 3
  end
end

STUCKED_LIGHTS = [[0, 0], [0, 99], [99, 0], [99, 99]]
def find_light(grid, i, j)
  return true if STUCKED_LIGHTS.include?([i, j])
  return nil if j < 0 || i < 0
  grid.dig(i, j)
end

def next_state_p2(grid, i, j)
  return true if STUCKED_LIGHTS.include?([i, j])

  neighbors_on = [
    find_light(grid, i, j + 1),
    find_light(grid, i, j - 1),
    find_light(grid, i - 1, j),
    find_light(grid, i + 1, j),
    # diagonals
    find_light(grid, i - 1, j + 1),
    find_light(grid, i + 1, j - 1),
    find_light(grid, i - 1, j - 1),
    find_light(grid, i + 1, j + 1),
  ].compact.select(&:itself).size

  if find_light(grid, i, j)
    neighbors_on == 2 || neighbors_on == 3
  else
    neighbors_on == 3
  end
end

grid = []
File.read('input').lines.each { |line| grid << line.chomp.chars.map { |c| c == "#" } }

100.times do
  next_grid = []
  for i in 0..99
    next_grid << []
    for j in 0..99
      # next_grid[i] << next_state(grid, i, j) # for part 1
      next_grid[i] << next_state_p2(grid, i, j) # for part 2
    end
  end

  # to display the swaggy animation
  system "clear"
  next_grid.each do |row|
    puts row.map { |c| c ? "#" : "." }.join
  end

  grid = next_grid
end

p grid.flatten.select(&:itself).size
