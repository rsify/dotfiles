const hyper = key => `${key}:ctrl,alt,cmd,shift`

const boundApps = {
	'3': 'MacDown',
	'a': 'Slack',
	'b': 'Airtable',
	'c': 'Caprine',
	'd': '2Do',
	'f': 'FileZilla',
	'g': 'Google Chrome',
	'h': 'Insomnia',
	'i': 'Discord',
	'l': 'SnippetsLab',
	'm': 'Mail',
	'p': 'Postico',
	'r': 'Microsoft Remote Desktop',
	's': 'Safari',
	't': 'kitty'
}

for (const key in boundApps) {
	const app = boundApps[key]
	slate.bind(hyper(key), slate.operation('focus', {
		app
	}))
}

slate.bind(hyper('\`'), slate.operation('relaunch'))
