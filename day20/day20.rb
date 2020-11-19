# shoutout to that stackoverflow post
def divisors(n)
  divisors = []
  large_divisors = []
  for i in 1..(Math.sqrt(n) + 1)
    if (n % i).zero?
      divisors << i

      if i * i != n
        large_divisors << n / i
      end
    end
  end

  divisors + large_divisors.reverse
end

house = 1
loop do
  # presents = divisors(house).sum { |n| n * 10 } # part 1
  presents = divisors(house)
    .select { |n| n * 50 >= house }
    .sum { |n| n * 11 }

  if presents >= 33100000
    p "##{house}: #{presents}"
    break
  end

  house += 1
end
