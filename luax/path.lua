--[[
  LuaX - Simple Path related methods, with Love!

  You probably should rather use:
  - https://keplerproject.github.io/luafilesystem/
--]]

local Path = {}

function Path.basename(path)
  local split = Path.split(path, "/")
  return split[#split]
end

function Path.dirname(path)
  if luax.ends(path, "/") then
    path = path .. "/"
  end
  local split = Path.split(path, "/")
  return split[#split - 1]
end

function Path.split(path, sep)
  local paths = luax.Array:new()
  for s in string.gmatch(path, "([^" .. (sep or "/") .. "]+)") do
    paths:pushlast(s)
  end
  return paths
end

function Path.cwd()
  -- you should probably use something more rebust than this
  return os.getenv("PWD") or io.popen("cd && cd -"):read()
end

-- this could only work if you call this from main.lua or adjacent file
Path.root = Path.cwd() .. "/"

return Path
