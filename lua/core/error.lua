-- JmespathFree SDK error

local JmespathFreeError = {}
JmespathFreeError.__index = JmespathFreeError


function JmespathFreeError.new(code, msg, ctx)
  local self = setmetatable({}, JmespathFreeError)
  self.is_sdk_error = true
  self.sdk = "JmespathFree"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function JmespathFreeError:error()
  return self.msg
end


function JmespathFreeError:__tostring()
  return self.msg
end


return JmespathFreeError
