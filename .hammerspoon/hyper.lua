mappings = require('hyper-apps')

hyper = {'shift', 'ctrl', 'alt', 'cmd'}

for i, mapping in ipairs(mappings) do
	hs.hotkey.bind(hyper, mapping[1], function()
		local appName = mapping[2]
		local app = hs.application.get(appName)
		if app then
			app:activate()
		else
			hs.application.launchOrFocus(appName)
		end
	end)
end

help_alert_uuid = nil
function show_help()
	str = ''
	for i, mapping in ipairs(mappings) do
		str = str .. mapping[1] .. ' ⇒ ' .. mapping[2] .. '\n'
	end

	help_alert_uuid = hs.alert(str:sub(1, -2), {
		atScreenEdge = 1,
		textFont = 'DejaVu Sans Mono'
	}, 'inf')
end

function hide_help()
	print('hiding')
	if help_alert_uuid then
		print('hiding fo real')
		hs.alert.closeSpecific(help_alert_uuid)
		help_alert_uuid = nil
	end
end

hs.hotkey.bind(hyper, '\\', show_help, hide_help)
