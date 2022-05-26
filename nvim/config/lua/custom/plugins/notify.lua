local present, notify = pcall(require, "notify")

if not present then
	return
end

notify.setup()

vim.notify = function(msg, log_level)
	if msg:match("exit code") then
		return
	end

	notify(msg, log_level)
end
