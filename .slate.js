const hyper = key => `${key}:ctrl,alt,cmd,shift`

const boundApps = {
	's': 'Safari',
	'd': '2Do',
	'h': 'Dash',
	'l': 'Snippets Lab',
	'm': 'Caprine',
	's': 'Safari',
	't': 'titty',
}

for (const key in boundApps) {
	const app = boundApps[key]
	slate.bind(hyper(key), slate.operation('focus', {
		app
	}))
}

slate.bind(hyper('\`'), slate.operation('relaunch'))
