import 'dart:io';
import 'dart:typed_data';
import 'package:Smarthome/constants/certificates.dart';
import 'package:Smarthome/constants/constants.dart';
import 'package:x509/x509.dart' as x509;
import 'package:asn1lib/asn1lib.dart' as asn1;
import 'package:basic_utils/basic_utils.dart';

class HTTP {
  static bool ValidateCaCertificate(
    X509Certificate cert,
    String host,
    int port,
  ) {
    // re-parse certificate
    x509.X509Certificate certificate = x509.parsePem(cert.pem).single;
    x509.Signature signature = new x509.Signature(
      Uint8List.fromList(certificate.signatureValue!),
    );

    x509.Verifier? verifier = null;

    // check if root ca or intermediate ca should be used
    if (cert.issuer.contains(CNs[CertificateType.ROOT]!)) {
      verifier = Certificates.rootCA.publicKey.createVerifier(
        x509.algorithms.signing.rsa.sha256,
      );
    } else if (cert.issuer.contains(CNs[CertificateType.INTERMEDIATE]!)) {
      verifier = Certificates.intermediateCA.publicKey.createVerifier(
        x509.algorithms.signing.rsa.sha256,
      );
    } else {
      return false;
    }

    // check alternative ips
    if (cert.subject.contains(CNs[CertificateType.APP_SERVER]!) &&
        checkSANs(cert, host) == false) {
      return false;
    }

    // parse asn1
    var asn1Parser = asn1.ASN1Parser(cert.der);
    var seq = asn1Parser.nextObject() as asn1.ASN1Sequence;
    var tbsSequence = seq.elements[0] as asn1.ASN1Sequence;

    // validate certificate signature
    bool valid = verifier.verify(tbsSequence.encodedBytes, signature);
    return valid;
  }

  static bool checkSANs(cert, host) {
    List<String> sanIPs = X509Utils.x509CertificateFromPem(cert.pem)
        .subjectAlternativNames!
        .toList();

    if (sanIPs.contains(host) || (IS_DEBUGGING && host == EMULATOR_HOST)) {
      return true;
    }
    return false;
  }
}
