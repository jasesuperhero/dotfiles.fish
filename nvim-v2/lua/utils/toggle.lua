local M = {}

function M.inlay_hints(buf, value)
  local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
  if type(ih) == "function" then
    ih(buf, value)
  elseif type(ih) == "table" and ih.enable then
    if value == nil then value = not ih.is_enabled(buf) end
    ih.enable(buf, value)
  end
end

setmetatable(M, {
  __call = function(m, ...) return m.option(...) end,
})

return M
