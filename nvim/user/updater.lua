-- Configure AstroNvim updates
return {
  remote = "origin", -- remote to use
  channel = "stable", -- "stable" or "nightly"
  version = "v3.*", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
  pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
  skip_prompts = false, -- skip prompts about breaking changes
  show_changelog = true, -- show the changelog after performing an update
  auto_quit = false, -- automatically quit the current session after a successful update
}
