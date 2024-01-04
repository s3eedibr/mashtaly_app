import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Constants/colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingScreen> {
  final _nameController = TextEditingController();
  final _emilController = TextEditingController();
  final _phoneController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emilController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        width: 400,
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            Form(
                              child: Column(
                                children: [
                                  TextForm(Icons.person, data['name'],
                                      _nameController),
                                  const SizedBox(height: 20),
                                  TextForm(Icons.mail, data['email'],
                                      _emilController),
                                  const SizedBox(height: 20),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          _resetPassword(data['email']);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                tPrimaryActionColor,
                                            side: BorderSide.none,
                                            shape: const StadiumBorder()),
                                        child: const Text("Rest password",
                                            style: TextStyle(
                                                color: tPrimaryTextColor)),
                                      ),
                                      const SizedBox(width: 15),
                                      ElevatedButton(
                                        onPressed: () {
                                          updateData(data['id']);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                tPrimaryActionColor,
                                            side: BorderSide.none,
                                            shape: const StadiumBorder()),
                                        child: const Text("Save Profile",
                                            style: TextStyle(
                                                color: tPrimaryTextColor)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Text("loading");
        });
  }

  TextFormField TextForm(
    IconData ico,
    String hint,
    TextEditingController controller,
  ) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is requierd';
        } else {
          return null;
        }
      },
      controller: controller,
      cursorColor: tPrimaryActionColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        prefixIcon: Icon(
          ico,
          color: tPrimaryActionColor,
          size: 28,
        ),
        hintText: hint,
        hintStyle: const TextStyle(
            color: tPrimaryTextColor, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: tPrimaryActionColor,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: tPrimaryActionColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
    );
  }

  void updateData(String documentId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference user = firestore.collection('users');
    if (_nameController.text.trim() != "" &&
        _emilController.text.trim() != "") {
      try {
        DocumentReference userRef = user.doc(documentId);
        await userRef.update({
          'name': _nameController.text.trim(),
          'email': _emilController.text.trim(),
        });
        print('Document updated successfully');
      } catch (error) {
        print('Error updating document: $error');
      }
    }
  }

  Future<void> _resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      // Show a success message or navigate to a success screen
      print('Password reset email sent successfully.');
    } catch (e) {
      // Show an error message
      print('Error sending password reset email: $e');
    }
  }
}
