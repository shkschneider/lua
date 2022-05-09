local Log = {}

Log.FILENAME = Path.basename(Path.root or "log") .. ".log"
Log.FILE = io.open(Log.FILENAME, "w+")

function Log.close()
  if Log.FILE ~= nil then
    Log.FILE:flush()
    Log.FILE:close()
  end
end

local function _log(level, ...)
  for _, s in ipairs{...} do
    local _s = os.date("%c") .. " [" .. level:upper() .. "] " .. tostring(s)
    print(_s)
    if Log.FILE ~= nil then
      Log.FILE:write(_s .. "\n")
    end
  end
  if Log.FILE ~= nil then
    Log.FILE:flush()
  end
end

function Log.verbose(...)
  _log("verbose", ...)
end

function Log.debug(...)
  _log("debug", ...)
end

function Log.info(...)
  _log("info", ...)
end

function Log.warning(...)
  _log("warning", ...)
end

function Log.error(...)
  _log("error", ...)
end

function Log:wtf(...)
  _log("wtf", ...)
  Log:close()
  exit(1)
end

return Log
