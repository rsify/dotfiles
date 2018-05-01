hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
	hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function(files)
	doReload = false
	for _,file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end):start()

require('hyper')
require('2do-sync')

hs.notify.new({title='Hammerspoon', informativeText='Ready!'}):send()
