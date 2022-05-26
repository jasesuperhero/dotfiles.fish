local present, troubles = pcall(require, "troubles")

if not present then
	return
end

troubles.setup()
