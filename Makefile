VERSION=13.2-RELEASE

create:
	bastille bootstrap ${VERSION} update
	bastille create xanadu ${VERSION} 10.0.10.1
	bastille create kubla ${VERSION} 10.0.10.2
	bastille create khan ${VERSION} 10.0.10.3

update:
	bastille template xanadu frenata/coleridge/xanadu
	bastille template kubla frenata/coleridge/kubla
	bastille template khan frenata/coleridge/khan

test:
	curl 10.0.10.1
