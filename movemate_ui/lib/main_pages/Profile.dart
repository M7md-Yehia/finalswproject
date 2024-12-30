import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:movemate_ui/main_pages/Forget.dart';
import 'package:movemate_ui/main_pages/login.dart';

class Profile extends StatefulWidget {
  final String username; // Receive the username as a parameter
  final String email; // Optional email if needed

  const Profile({Key? key, required this.username, required this.email})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController nameController; // Use actual username

  // Controllers for password change
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  // Flag for edit mode
  bool isEditingName = false;

  @override
  void initState() {
    super.initState();
    // Initialize the name controller with the username from the parent widget
    nameController = TextEditingController(text: widget.username);
  }

  // Function to change the password
  Future<void> changePassword() async {
    const String apiUrl =
        "https://e50b-45-243-12-201.ngrok-free.app/api/change-password-no-auth/";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': widget.username, // Use the actual username
          'old_password': oldPasswordController.text,
          'new_password': newPasswordController.text,
        }),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Password changed successfully!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        final errorData = json.decode(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(errorData['error'] ?? 'Failed to change password'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffED9E59),
            Color.fromARGB(255, 223, 186, 184),
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff44174E),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Picture
            const Center(
              child: Image(
                width: 160,
                height: 130,
                image: AssetImage('assets/images/Profile pic.png'),
              ),
            ),
            const SizedBox(height: 20),

            // Name Field with Edit Functionality
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(25),
              ),
              width: 350,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 24,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: isEditingName
                          ? TextField(
                              controller: nameController,
                              style: const TextStyle(fontSize: 18),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onSubmitted: (value) {
                                setState(() {
                                  isEditingName = false;
                                });
                              },
                            )
                          : Text(
                              nameController.text,
                              style: const TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isEditingName = !isEditingName;
                        });
                      },
                      child: Icon(
                        isEditingName ? Icons.check : Icons.edit,
                        size: 24,
                        color: isEditingName ? Colors.green : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Email Field
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(25),
              ),
              width: 350,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.email_sharp,
                      size: 24,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.email, // Use actual email from parent widget
                        style: const TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Change Password Button
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Change Password'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: oldPasswordController,
                            decoration: const InputDecoration(
                              labelText: 'Old Password',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: newPasswordController,
                            decoration: const InputDecoration(
                              labelText: 'New Password',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            changePassword();
                          },
                          child: const Text('Change'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff44174E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Log Out Button
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => login(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff44174E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
