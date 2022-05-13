--[[
  LuaX - Simple logger, with Love!

  - opens a file in current directory with its name
  - prints to console and to file
  - multiple levels
--]]

local Log = {}

--[[ levels ]]--

Log.Levels = {}

Log.Level = luax.Class:new()
function Log.Level:constructor(code, name)
  assert(type(code) == "number")
  assert(type(name) == "string")
  self.code = code
  self.name = name
end

Log.Levels.Verbose = Log.Level(1, "verbose")
Log.Levels.Debug = Log.Level(2, "debug")
Log.Levels.Info = Log.Level(3, "info")
Log.Levels.Warning = Log.Level(4, "warning")
Log.Levels.Error = Log.Level(5, "error")
Log.Levels.WTF = Log.Level(6, "error")

--[[ log ]]--

Log._LEVEL = Log.Levels.Verbose
Log._FILENAME = luax.Path.basename(luax.Path.root or "log") .. ".log"
Log._FILE = io.open(Log._FILENAME, "w+")

function Log.level(lvl)
  if type(lvl) == "class" then
    Log._LEVEL = lvl
  end
  return Log._LEVEL
end

function Log.close()
  if Log._FILE ~= nil then
    Log._FILE:flush()
    Log._FILE:close()
  end
end

local function _log(level, ...)
  if level.code < Log._LEVEL.code then return end
  for _, s in ipairs{...} do
    local _s = os.date("%c") .. " [" .. level.name:upper() .. "] " .. tostring(s)
    print(_s)
    if Log._FILE ~= nil then
      Log._FILE:write(_s .. "\n")
    end
  end
  if Log._FILE ~= nil then
    Log._FILE:flush()
  end
end

function Log.verbose(...)
  _log(Log.Levels.Verbose, ...)
end

function Log.debug(...)
  _log(Log.Levels.Debug, ...)
end

function Log.info(...)
  _log(Log.Levels.Info, ...)
end

function Log.warning(...)
  _log(Log.Levels.Warning, ...)
end

function Log.error(...)
  _log(Log.Levels.Error, ...)
end

function Log:wtf(...)
  _log(Log.Levels.WTF, ...)
  Log:close()
  exit(1)
end

return Log
