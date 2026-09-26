import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

/// Certificate pinning for every request made to the TMDB API.
///
/// Instead of trusting whatever certificate authorities happen to be in the
/// OS trust store (which is what a plain `http.Client()` does), this loads
/// the API's own root CA certificate from app assets and only accepts
/// connections whose certificate chain is verifiable against it. This
/// blocks a large class of man-in-the-middle attacks (e.g. a malicious or
/// compromised network / proxy presenting a certificate signed by some
/// other, otherwise "valid", CA).
///
/// See assets/certificates/README.md for how to generate the pinned
/// certificate file.
class SslPinning {
  static const _certificateAssetPath =
      'assets/certificates/api_themoviedb_org.pem';

  /// Loads the pinned certificate bytes from the asset bundle. Call this
  /// once, before [client], typically during app start-up in `main()`.
  static Future<Uint8List> loadCertificate() async {
    final ByteData data = await rootBundle.load(_certificateAssetPath);
    return data.buffer.asUint8List();
  }

  /// Builds an [http.Client] that only accepts TLS connections whose
  /// certificate chains back to [certificateBytes].
  static http.Client client(Uint8List certificateBytes) {
    final securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(certificateBytes);

    final httpClient = HttpClient(context: securityContext)
      // Trust only the pinned certificate: reject anything the
      // SecurityContext above didn't already validate.
      ..badCertificateCallback = (cert, host, port) => false;

    return IOClient(httpClient);
  }
}
