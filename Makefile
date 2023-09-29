VERSION=13.2-RELEASE

create:
	doas bastille bootstrap ${VERSION} update
	doas bastille create khan ${VERSION} 10.0.10.3
	doas bastille create kubla ${VERSION} 10.0.10.2
	doas bastille create xanadu ${VERSION} 10.0.10.1

update:
	@test -n "$(DB_PASS)" || (echo 'You must define DB_PASS' && exit 1)
	doas bastille template khan frenata/coleridge/shared
	doas bastille restart khan
	doas bastille template khan frenata/coleridge/khan --arg db_pass=${DB_PASS}
	doas bastille template kubla frenata/coleridge/kubla --arg db_pass=${DB_PASS}
	doas bastille template xanadu frenata/coleridge/xanadu

test:
	curl 10.0.10.1

clean:
	doas bastille stop xanadu
	doas bastille stop kubla
	doas bastille stop khan
	doas bastille destroy xanadu
	doas bastille destroy kubla
	doas bastille destroy khan
