require "hash_sha1"

luax.hash = function (s)
  return sha1(tostring(s))
end

