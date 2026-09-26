# SSL Pinning Certificate

`api_themoviedb_org.pem` in this folder is what `lib/common/ssl_pinning.dart`
loads and pins against for every request to `api.themoviedb.org`. It is
**not included** in this repository because it must be generated from the
live server's real certificate chain — do this once, on your own machine,
before building the app:

```bash
# 1. Grab the full certificate chain presented by the API host.
openssl s_client -connect api.themoviedb.org:443 -showcerts </dev/null 2>/dev/null \
  > full_chain.txt

# 2. Extract the ROOT CA certificate (the last -----BEGIN CERTIFICATE----- /
#    -----END CERTIFICATE----- block in full_chain.txt). Pinning the root
#    (rather than the leaf, which TMDB rotates far more often) keeps the app
#    working across their normal certificate renewals.
#    Copy that block into a new file named exactly:
#      assets/certificates/api_themoviedb_org.pem

# 3. Sanity-check it parses:
openssl x509 -in assets/certificates/api_themoviedb_org.pem -noout -text
```

If TMDB ever rotates to a different root CA, requests will start failing
with a `HandshakeException` and you'll need to regenerate this file the
same way.

`pubspec.yaml` already declares the whole `assets/` folder, so once the
`.pem` file is in place no further pubspec changes are needed.
