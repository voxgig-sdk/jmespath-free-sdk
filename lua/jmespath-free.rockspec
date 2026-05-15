package = "voxgig-sdk-jmespath-free"
version = "0.0-1"
source = {
  url = "git://github.com/voxgig-sdk/jmespath-free-sdk.git"
}
description = {
  summary = "JmespathFree SDK for Lua",
  license = "MIT"
}
dependencies = {
  "lua >= 5.3",
  "dkjson >= 2.5",
  "dkjson >= 2.5",
}
build = {
  type = "builtin",
  modules = {
    ["jmespath-free_sdk"] = "jmespath-free_sdk.lua",
    ["config"] = "config.lua",
    ["features"] = "features.lua",
  }
}
