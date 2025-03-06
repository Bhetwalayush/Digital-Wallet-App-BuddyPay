import 'package:buddypay_digital_wallet/app/shared_prefs/user_shared_prefs.dart';
import 'package:buddypay_digital_wallet/features/send_credits/presentation/view/send_credits_view.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  bool isQRCodeSelected = true;
  String fullname = "";
  String phone = "";
  bool isLoading = true;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  late UserSharedPrefs userSharedPrefs;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  @override
  void dispose() {
    // Dispose of the controller when leaving the screen
    controller?.dispose();
    super.dispose();
  }

  Future<void> _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    userSharedPrefs = UserSharedPrefs(prefs);

    final loadedFullname = await userSharedPrefs.getUserName();
    final loadedPhone = await userSharedPrefs.getPhone();

    loadedFullname.fold(
      (failure) {
        setState(() {
          fullname = 'Error loading user name';
          isLoading = false;
        });
      },
      (name) {
        setState(() {
          fullname = name ?? 'User';
        });
      },
    );

    loadedPhone.fold(
      (failure) {
        setState(() {
          phone = 'Error loading phone';
          isLoading = false;
        });
      },
      (ph) {
        setState(() {
          phone = ph ?? '0000000000';
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Code")),
      body: Column(
        children: [
          ToggleButtons(
            isSelected: [isQRCodeSelected, !isQRCodeSelected],
            onPressed: (index) {
              setState(() {
                isQRCodeSelected = index == 0;
              });
            },
            borderRadius: BorderRadius.circular(10),
            children: const [
              Padding(padding: EdgeInsets.all(10), child: Text("QR Code")),
              Padding(padding: EdgeInsets.all(10), child: Text("Scan")),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : (isQRCodeSelected
                    ? _buildQRCodeView()
                    : _buildQRScannerView()),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeView() {
    String qrData = "$fullname,$phone";
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 200,
        ),
      ),
    );
  }

  Widget _buildQRScannerView() {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        List<String> qrDetails = scanData.code!.split(',');
        if (qrDetails.length == 2) {
          String scannedFullname = qrDetails[0];
          String scannedPhone = qrDetails[1];

          // Stop scanning when a QR code is detected
          controller.pauseCamera();

          // Navigate to CreditScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreditScreen(
                fullname: scannedFullname,
                phone: scannedPhone,
              ),
            ),
          ).then((_) {
            // Ensure to stop the QR scan and release the camera when navigating away
            controller.stopCamera();
          });
        }
      }
    });
  }
}
