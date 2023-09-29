VERSION=13.2-RELEASE

create:
	doas bastille bootstrap ${VERSION} update
	doas bastille create xanadu ${VERSION} 10.0.10.1
	doas bastille create kubla ${VERSION} 10.0.10.2
	doas bastille create khan ${VERSION} 10.0.10.3

update:
	doas bastille template xanadu frenata/coleridge/xanadu
	doas bastille template kubla frenata/coleridge/kubla
	doas bastille template khan frenata/coleridge/shared
	doas bastille restart khan
	doas bastille template khan frenata/coleridge/khan

test:
	curl 10.0.10.1

clean:
	doas bastille stop xanadu
	doas bastille stop kubla
	doas bastille stop khan
	doas bastille destroy xanadu
	doas bastille destroy kubla
	doas bastille destroy khan
