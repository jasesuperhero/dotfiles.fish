local LazyUtil = require "lazy.core.util"

local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then return LazyUtil[k] end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("utils." .. k)
    return t[k]
  end,
})

function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then return {} end
  local Plugin = require "lazy.core.plugin"
  return Plugin.values(plugin, "opts", false)
end

function M.has(plugin) return require("lazy.core.config").spec.plugins[plugin] ~= nil end

function M.is_win() return vim.uv.os_uname().sysname:find "Windows" ~= nil end

function M.on_load(name, fn)
  local Config = require "lazy.core.config"
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

function M.get_kind_filter(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local ft = vim.bo[buf].filetype
  if User.kind_filter == false then return end
  if User.kind_filter[ft] == false then return end
  if type(User.kind_filter[ft]) == "table" then return User.kind_filter[ft] end
  ---@diagnostic disable-next-line: return-type-mismatch
  return type(User.kind_filter) == "table" and type(User.kind_filter.default) == "table" and User.kind_filter.default
    or nil
end

return M
