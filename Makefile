VERSION=13.2-RELEASE

create:
	doas bastille bootstrap ${VERSION} update
	doas bastille create khan ${VERSION} 10.0.10.3
	doas bastille create kubla-1 ${VERSION} 10.0.10.2
	doas bastille create kubla-2 ${VERSION} 10.0.10.4
	doas bastille create xanadu ${VERSION} 10.0.10.1

update:
	@test -n "$(DB_PASS)" || (echo 'You must define DB_PASS' && exit 1)
	doas bastille template khan frenata/coleridge/shared
	doas bastille restart khan
	doas bastille template khan frenata/coleridge/khan --arg db_pass=${DB_PASS}
	doas bastille template kubla-1 frenata/coleridge/kubla --arg db_pass=${DB_PASS}
	doas bastille template kubla-2 frenata/coleridge/kubla --arg db_pass=${DB_PASS}
	doas bastille template xanadu frenata/coleridge/xanadu

test:
	curl 10.0.10.1

clean:
	doas bastille stop xanadu
	doas bastille stop kubla-1
	doas bastille stop kubla-2
	doas bastille stop khan
	doas bastille destroy xanadu
	doas bastille destroy kubla-1
	doas bastille destroy kubla-2
	doas bastille destroy khan
