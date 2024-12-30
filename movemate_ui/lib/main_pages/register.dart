import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool Passwordhidden = true;
  bool Passwordhidden2 = true;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';
  String? _selectedRole;

  // Backend Integration: Register user function
  Future<void> registerUser() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Passwords do not match!';
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            'https://e50b-45-243-12-201.ngrok-free.app/api/auth/register/'), // Replace with your actual backend URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
          'confirm_password': _confirmPasswordController.text,
          'role': _selectedRole,
        }),
      );

      if (response.statusCode == 201) {
        // Registration success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User registered successfully!')),
        );
        Navigator.pop(context); // Navigate back to login or previous screen
      } else {
        // Show error message from backend
        final errorData = json.decode(response.body);
        setState(() {
          _errorMessage = errorData['error'] ?? 'Registration failed!';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
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
            'Shipment Tracking',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff44174E),
        ),
        body: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  height: 150,
                  width: 150,
                  child: const Image(
                    image: AssetImage(
                        'assets/images/download-removebg-preview.png'),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Image(
                image: AssetImage('assets/images/Register.png'),
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'User',
                    labelStyle: const TextStyle(color: Colors.blue),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 25, right: 10),
                      child: Icon(Icons.supervised_user_circle_sharp),
                    ),
                    prefixIconColor: Colors.purple,
                    hintText: 'Enter your Username',
                    hintStyle: const TextStyle(color: Colors.purple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'Mail',
                    labelStyle: const TextStyle(color: Colors.blue),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 25, right: 10),
                      child: Icon(Icons.mail),
                    ),
                    prefixIconColor: Colors.purple,
                    hintText: 'Enter your Email Address',
                    hintStyle: const TextStyle(color: Colors.purple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextField(
                  controller: _passwordController,
                  obscureText: Passwordhidden,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Passwordhidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          Passwordhidden = !Passwordhidden;
                        });
                      },
                    ),
                    suffixIconColor: Colors.purple,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 25, right: 10),
                      child: Icon(Icons.lock),
                    ),
                    prefixIconColor: Colors.purple,
                    hintText: 'Enter your Password',
                    hintStyle: const TextStyle(color: Colors.purple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: Passwordhidden2,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'Confirm Password',
                    labelStyle: const TextStyle(color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Passwordhidden2
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          Passwordhidden2 = !Passwordhidden2;
                        });
                      },
                    ),
                    suffixIconColor: Colors.purple,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 25, right: 10),
                      child: Icon(Icons.lock),
                    ),
                    prefixIconColor: Colors.purple,
                    hintText: 'Confirm your Password',
                    hintStyle: const TextStyle(color: Colors.purple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'Select Role',
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'Delivery_Person',
                      child: Text('Delivery Person'),
                    ),
                    DropdownMenuItem(
                      value: 'Shipment_Tracker',
                      child: Text('Shipment Tracker'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a role';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            ),
            Container(
              width: 300,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 36, 105, 255),
                    Color.fromARGB(255, 214, 19, 204),
                  ],
                ),
              ),
              child: Center(
                child: TextButton(
                  onPressed: registerUser,
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
