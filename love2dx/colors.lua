local Colors = {}

function Colors.rgb(r, g, b)
  assert(type(r) == "number" or type(r) == "nil")
  assert(type(g) == "number" or type(r) == "nil")
  assert(type(b) == "number" or type(r) == "nil")
  r = r or 255
  g = g or 255
  b = b or 255
  return { r = r / 255, g = g / 255, b = b / 255 }
end

function Colors.rgba(r, g, b, a)
  assert(type(r) == "number" or type(r) == "nil")
  assert(type(g) == "number" or type(r) == "nil")
  assert(type(b) == "number" or type(r) == "nil")
  assert(type(a) == "number" or type(r) == "nil")
  r = r or 255
  g = g or 255
  b = b or 255
  a = a or 1
  return { r = r / 255, g = g / 255, b = b / 255, a = a }
end

return Colors
