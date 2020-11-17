# containers is just the list of containers at our disposition
# capacity is the remaining capacity to fill
# i is the container selected for the current selection
# current_selection is the current selection tested
# selection is a list of successful arangement
def solve(containers, capacity, i, current_selection, selections)
  if capacity == 0
    selections << current_selection
    return
  elsif i < 0
    return
  elsif containers[i] > capacity # skip this container since it's no use
    solve(containers, capacity, i - 1, current_selection, selections)
  else
    solve(containers, capacity, i - 1, current_selection.dup, selections)

    current_selection << containers[i]
    solve(containers, capacity - containers[i], i - 1, current_selection, selections)
  end
end

containers = File.read('input').lines.map(&:to_i)

results = []
solve(containers, 150, containers.size-1, [], results)
p "part 1: #{results.size}"

# part 2
min_size = results.map(&:size).min
p "part 2: #{results.select { |result| result.size == min_size }.size}"
