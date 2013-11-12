# Bot periodista

> John Silas Reed (Portland, Oregón, 22 de octubre de 1887 - Moscú, 19
> de octubre de 1920), periodista, poeta y activista comunista
> estadounidense, célebre por su testimonio de la Revolución Rusa Diez
> días que estremecieron el mundo. Su esposa fue la escritora feminista
> Louise Bryant. -- [Wikipedia](http://es.wikipedia.org/wiki/John_Reed)

Reed es un cyborg que twittea todo lo que se dice en un canal.  La idea
es usarlo para cubrir entre varios un evento, o sólo mantener una cuenta
de twitter colectivamente.

## Uso

Copiar `config.rb.example` sin la extensión y configurar a gusto.

    bundle install --path=vendor
    ./daemonize &>/dev/null

Para empezar a enviar, decir "+j".  Para dejar, "-j".  Por seguridad,
cuando alguien entra en el canal y Reed está esperando texto, se llama a
silencio.

### Hashtags por defecto

Reed va a usar el nombre del canal actual como hashtag, agregándolo al
final de la frase.

Para que Reed ingrese en distintos canales/hashtags, agregarlo con
`config.rb` o invitarlo usando comandos de IRC, por ejemplo (en tu
cliente IRC):

    /join #ProbandoReed
    /invite reed
