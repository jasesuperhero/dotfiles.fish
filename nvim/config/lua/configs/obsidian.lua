return {
  workspaces = {
    { name = "notes", path = "~/Documents/notes" },
  },

  completion = { nvim_cmp = false, min_chars = 2 },

  new_notes_location = "current_dir",
  preferred_link_style = "wiki",

  -- Generates a permanent, sortable note ID: 14-digit timestamp + slug.
  -- Example: "20260413142357-my-note-title"
  note_id_func = function(title)
    local suffix = ""
    if title ~= nil then
      suffix = "-" .. title:gsub(" ", "-"):gsub("[^a-zA-Z0-9-]", ""):lower()
    else
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.date "%Y%m%d%H%M%S") .. suffix
  end,

  -- Writes id, aliases, tags to YAML frontmatter. Preserves any extra fields.
  note_frontmatter_func = function(note)
    local out = { id = note.id, aliases = note.aliases, tags = note.tags }
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end
    return out
  end,

  templates = {
    folder = "05_Templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
  },

  daily_notes = {
    folder = "daily",
    date_format = "%Y-%m-%d",
  },

  ui = { enable = false },
}
