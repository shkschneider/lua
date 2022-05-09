math.randomseed(os.time())

luax.randomtable = function (table)
  return table[math.random(#table)]
end

luax.randomboolean = function ()
  return luax.randomtable({true, false})
end
