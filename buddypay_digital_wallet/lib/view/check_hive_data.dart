import 'package:hive/hive.dart';

Future<void> checkDataSaved() async {
  // Open the Hive box
  var box = await Hive.openBox('yourBoxName');

  // Fetch the data using the key you used to store it
  var data = box.get('yourDataKey'); // replace 'yourDataKey' with the actual key

  // Check if data is present
  if (data != null) {
    print('Data is saved: $data');
  } else {
    print('No data found');
  }
}

void main() {
  // Call the checkDataSaved method to verify data
  checkDataSaved();
}
