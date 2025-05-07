Redirect Woozle
===============

This project is heavily inspired by a Justin Searls's
"[Redirect Dingus][dingus]". Like him, I also have a collection of domains that
are just redirects, and I wanted them to support TLS. What I don't have is a
Heroku account, but what I _do_ have is a [Kamal][kamal] install for running
some of my other "real" websites.

So, I could probably add one more "app" that is just a Nginx config, right?

Configuration
-------------

The main configuration is in `redirects.yml`. Each entry in the `redirects:`
array contains a `from:` and a `to:` key. The from keys will be used as "hosts"
for the Kamal proxy server and the Nginx server will answer requests for those
hosts. The redirect entry can also contain an HTTP `code:` key (`301` by
default). If the code is a `3xx`, the Nginx server will redirect to the `to:`
address. Otherwise, it will use the `to:` value as the body of the response.

There _is_ a `default` `from:` entry. This would be used as the target for any
otherwise unmatched requests, but given the way Kamal proxy works, requests
that aren't for one of the other configured hosts _shouldn't_ end up at this
app.

[dingus]: https://github.com/searls/redirect-dingus
[kamal]: https://kamal-deploy.org/
