local Version = luax.Class:new("version")

function Version:constructor(major, minor, patch)
  assert(major ~= nil)
  assert(type(major) == "number" or type(major) == "string")
  assert(minor ~= nil)
  assert(type(minor) == "number" or type(minor) == "string")
  assert(patch ~= nil)
  assert(type(patch) == "number" or type(patch) == "string")
  self.major = major
  self.minor = minor
  self.patch = patch
end

function Version:_before(version)
  if self.major < version.major then
    return true
  elseif self.major == version.major and self.minor < version.minor then
    return true
  elseif self.major == version.major and self.minor == version.minor and self.patch < version.patch then
    return true
  end
  return false
end

Version.__lt = function (first, second)
  return first:_before(second)
end

function Version:_after(version)
  if self.major < version.major then
    return true
  elseif self.major == version.major and self.minor < version.minor then
    return true
  elseif self.major == version.major and self.minor == version.minor and self.patch < version.patch then
    return true
  end
  return false
end

Version.__gt = function (first, second)
  return first:_after(second)
end

Version.__eq = function (first, second)
  return not first:_before(second) and not first:_after(second)
end

function Version:__tostring()
  return string.format("%d.%d.%d", self.major, self.minor, self.patch)
end

return Version
