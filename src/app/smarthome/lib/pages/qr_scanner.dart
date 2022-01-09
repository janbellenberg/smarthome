import 'package:Smarthome/controller/buildings.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QR_Scanner_Page extends StatelessWidget {
  QR_Scanner_Page(this.onSuccess, {Key? key}) : super(key: key) {
    success = false;
  }
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  late bool success;
  final Function(Barcode scaData) onSuccess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (controller) => _onQRViewCreated(
                controller,
                context,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller, context) {
    controller.scannedDataStream.listen((scanData) async {
      controller.stopCamera();
      Navigator.pop(context);
      onSuccess(scanData);
    });
  }
}
