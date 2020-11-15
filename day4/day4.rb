require 'digest'

nounce = 0

loop do
  hex = Digest::MD5.hexdigest "bgvyzdsv#{nounce}"

  if hex.start_with?("000000")
    p nounce
    return
  end

  nounce += 1
end

