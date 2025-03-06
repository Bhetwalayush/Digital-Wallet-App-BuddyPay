import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  Future<void> _getContacts() async {
    try {
      bool permissionGranted = await FlutterContacts.requestPermission();
      print("Permission granted: $permissionGranted");

      if (!permissionGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Contacts permission denied")));
        return;
      }

      List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true);
      print("Fetched ${contacts.length} contacts");

      setState(() {
        _contacts = contacts;
      });
    } catch (e) {
      print("Error fetching contacts: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),
      body: _contacts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                Contact contact = _contacts[index];
                return ListTile(
                  title: Text(contact.displayName),
                  subtitle: Text(contact.phones.isNotEmpty
                      ? contact.phones.first.number
                      : "No Number"),
                );
              },
            ),
    );
  }
}
