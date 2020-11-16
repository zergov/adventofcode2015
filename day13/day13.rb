graph = {}

File.read('input').lines do |line|
  words = line.chomp.split

  name = words[0]
  action = words[2]
  value = words[3].to_i
  next_to = words[10].gsub('.', '')

  value = action == "gain" ? value : -value

  if graph[name]
    graph[name][next_to] = value
  else
    graph[name] = {next_to => value}
  end
end

persons = graph.keys

persons.each do |person|
  graph[person]["me"] = 0
end

graph["me"] = persons.each_with_object({}) do |person, h|
  h[person] = 0
end

persons = graph.keys

results = []
persons.permutation.to_a.each do |table|
  happiness = 0
  table.each.with_index do |person, i|
    if i == 0
      happiness += graph[person][table.last]
      happiness += graph[person][table[i+1]]
    elsif i == table.size - 1
      happiness += graph[person][table[i-1]]
      happiness += graph[person][table.first]
    else
      happiness += graph[person][table[i-1]]
      happiness += graph[person][table[i+1]]
    end
  end

  results << happiness
end

p results.max
