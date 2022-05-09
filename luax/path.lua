local Path = {}

function Path.basename(path)
  return path:gsub("[/\\]*$", ""):match(".*[/\\]([^/\\]*)")
end

function Path.dirname(path)
  return path:gsub("/*$", ""):match("(.*)[/]+[^/]*")
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
Path.root = Path.cwd()

-- better then rely on https://keplerproject.github.io/luafilesystem/

return Path
