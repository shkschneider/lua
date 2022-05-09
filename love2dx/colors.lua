love2dx.rgba = function(r, g, b, a) -- range: 0-255
  assert(type(r) == "number")
  assert(type(g) == "number")
  assert(type(b) == "number")
  assert(type(a) == "number")
  return { r = r / 255, g = g / 255, b = b / 255, a = a  / 255 }
end

love2dx.rgb = function(r, g, b)
  return love2dx.rgba(r, g, b, 255)
end
