graph = {}

File.read('input').lines do |line|
  source, _, destination, _, distance = line.chomp.split

  distance = distance.to_i

  if graph[source]
    graph[source][destination] = distance
  else
    graph[source] = {destination => distance}
  end

  if graph[destination]
    graph[destination][source] = distance
  else
    graph[destination] = {source => distance}
  end
end

cities = graph.keys
possible_routes = cities.permutation.to_a

results = []
possible_routes.each do |route|

  distance = 0
  source = route.shift

  route.each do |destination|
    if graph[source].include?(destination)
      distance += graph[source][destination]
      source = destination
    else
      break
    end
  end

  results << distance
end

p results.select { |distance| distance > 0 }.max
