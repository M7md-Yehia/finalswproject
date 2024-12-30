// import 'package:flutter/material.dart';
// import 'package:movemate_ui/main_pages/Forget.dart';
// import 'package:movemate_ui/navigation_view.dart';
// import 'package:movemate_ui/navigation_view2.dart'; // Import the second navigation view
// import 'register.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class login extends StatefulWidget {
//   login({super.key});

//   @override
//   State<login> createState() => _loginState();
// }

// class _loginState extends State<login> {
//   bool PasswordHidden = true;
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;
//   String _errorMessage = ''; // Variable to store error messages

//   // Function to make API request to Django for login
//   Future<void> loginUser(String email, String password) async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = ''; // Reset the error message before sending the request
//     });

//     try {
//       final response = await http.post(
//         Uri.parse(
//             'https://e50b-45-243-12-201.ngrok-free.app/api/auth/login/'), // Change this to your Django server URL
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'username': email, // You can also use 'email' depending on your API
//           'password': password,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final token = data['access']; // JWT token
//         final role = data['role']; // Assuming the API returns a 'role' field

//         // Navigate based on the role
//         if (role == 'Delivery_Person') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     navigation_view2()), // Navigate to navigation_view2
//           );
//         } else if (role == 'Shipment_Tracker') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => navigation_view()),
//           );
//         }
//       } else {
//         // Handle error: Show error message
//         setState(() {
//           _errorMessage = 'Invalid username or password, please try again.';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'An error occurred: $e';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Color(0xffED9E59),
//             Color.fromARGB(255, 223, 186, 184),
//           ],
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: const Text(
//             'Shipment Tracking',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Color(0xff44174E),
//         ),
//         body: Column(
//           children: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   child: const Image(
//                     image: AssetImage(
//                         'assets/images/download-removebg-preview.png'),
//                   ),
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(top: 30),
//               child: Image(
//                 image: AssetImage('assets/images/Login.png'),
//               ),
//             ),
//             Container(
//               width: 350,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 50),
//                 child: TextField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 20),
//                     labelText: 'Username',
//                     labelStyle: const TextStyle(color: Colors.blue),
//                     prefixIcon: const Padding(
//                       padding: EdgeInsets.only(left: 25, right: 10),
//                       child: Icon(Icons.mail),
//                     ),
//                     prefixIconColor: Colors.purple,
//                     hintText: 'Enter your Username',
//                     hintStyle: const TextStyle(color: Colors.purple),
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.green),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: 350,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 25),
//                 child: TextField(
//                   controller: _passwordController,
//                   obscureText: PasswordHidden,
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 20),
//                     labelText: 'Password',
//                     labelStyle: const TextStyle(color: Colors.blue),
//                     suffixIcon: IconButton(
//                       icon: Icon(PasswordHidden
//                           ? Icons.visibility
//                           : Icons.visibility_off),
//                       onPressed: () {
//                         setState(() {
//                           PasswordHidden = !PasswordHidden;
//                         });
//                       },
//                     ),
//                     suffixIconColor: Colors.purple,
//                     prefixIcon: const Padding(
//                       padding: EdgeInsets.only(left: 25, right: 10),
//                       child: Icon(Icons.lock),
//                     ),
//                     prefixIconColor: Colors.purple,
//                     hintText: 'Enter your Password',
//                     hintStyle: const TextStyle(color: Colors.purple),
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.purple),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             // Error message display
//             if (_errorMessage.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Text(
//                   _errorMessage,
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.only(top: 30),
//               child: GestureDetector(
//                 onTap: () {
//                   String username = _emailController.text;
//                   String password = _passwordController.text;
//                   loginUser(username, password);
//                 },
//                 child: Container(
//                   width: 300,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     gradient: const LinearGradient(
//                       colors: [
//                         Color.fromARGB(255, 36, 105, 255),
//                         Color.fromARGB(255, 214, 19, 204),
//                       ],
//                     ),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       'Login',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 25),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 right: 190,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 40),
//                 child: Container(
//                   child: const Text(
//                     "Don't have an account",
//                     style: TextStyle(
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 60),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   Register()), // Navigate to Register screen
//                         );
//                       },
//                       child: const Text(
//                         'Sign up',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color.fromARGB(255, 7, 83, 145),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 120),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Forget(),
//                             ));
//                       },
//                       child: const Text(
//                         'Forget Password',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color.fromARGB(255, 7, 83, 145),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//test for backend to our code
// import 'package:flutter/material.dart';
// import 'package:movemate_ui/main_pages/Forget.dart';
// import 'package:movemate_ui/navigation_view.dart';
// import 'package:movemate_ui/navigation_view2.dart';
// import 'register.dart';

// class login extends StatefulWidget {
//   login({super.key});

//   @override
//   State<login> createState() => _loginState();
// }

// class _loginState extends State<login> {
//   bool PasswordHidden = true;
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;
//   String _errorMessage = ''; // Variable to store error messages

//   // Mocked function to simulate backend response for testing
//   Future<void> loginUser(String username, String password) async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = ''; // Reset the error message before sending the request
//     });

//     await Future.delayed(Duration(seconds: 2)); // Simulate network delay

//     // Mocked response for testing
//     final mockResponse = {
//       'access': 'mocked_jwt_token', // Mocked token
//       'role': username == 'delivery_user'
//           ? 'Delivery Person'
//           : 'Shipment Tracker', // Mock role based on username input
//     };

//     if (password == 'password123') {
//       final role = mockResponse['role'];

//       // Navigate based on the role
//       if (role == 'Delivery Person') {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   navigation_view2()), // Navigate to navigation_view2
//         );
//       } else if (role == 'Shipment Tracker') {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   navigation_view()), // Navigate to navigation_view
//         );
//       }
//     } else {
//       setState(() {
//         _errorMessage = 'Invalid username or password, please try again.';
//       });
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Color(0xffED9E59),
//             Color.fromARGB(255, 223, 186, 184),
//           ],
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: const Text(
//             'Shipment Tracking',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Color(0xff44174E),
//         ),
//         body: Column(
//           children: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   child: const Image(
//                     image: AssetImage(
//                         'assets/images/download-removebg-preview.png'),
//                   ),
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(top: 30),
//               child: Image(
//                 image: AssetImage('assets/images/Login.png'),
//               ),
//             ),
//             Container(
//               width: 350,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 50),
//                 child: TextField(
//                   controller: _usernameController,
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 20),
//                     labelText: 'Username',
//                     labelStyle: const TextStyle(color: Colors.blue),
//                     prefixIcon: const Padding(
//                       padding: EdgeInsets.only(left: 25, right: 10),
//                       child: Icon(Icons.person),
//                     ),
//                     prefixIconColor: Colors.purple,
//                     hintText: 'Enter your Username',
//                     hintStyle: const TextStyle(color: Colors.purple),
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.green),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: 350,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 25),
//                 child: TextField(
//                   controller: _passwordController,
//                   obscureText: PasswordHidden,
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 20),
//                     labelText: 'Password',
//                     labelStyle: const TextStyle(color: Colors.blue),
//                     suffixIcon: IconButton(
//                       icon: Icon(PasswordHidden
//                           ? Icons.visibility
//                           : Icons.visibility_off),
//                       onPressed: () {
//                         setState(() {
//                           PasswordHidden = !PasswordHidden;
//                         });
//                       },
//                     ),
//                     suffixIconColor: Colors.purple,
//                     prefixIcon: const Padding(
//                       padding: EdgeInsets.only(left: 25, right: 10),
//                       child: Icon(Icons.lock),
//                     ),
//                     prefixIconColor: Colors.purple,
//                     hintText: 'Enter your Password',
//                     hintStyle: const TextStyle(color: Colors.purple),
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Colors.purple),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             // Error message display
//             if (_errorMessage.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Text(
//                   _errorMessage,
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.only(top: 30),
//               child: GestureDetector(
//                 onTap: () {
//                   String username = _usernameController.text;
//                   String password = _passwordController.text;
//                   loginUser(username, password);
//                 },
//                 child: Container(
//                   width: 300,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     gradient: const LinearGradient(
//                       colors: [
//                         Color.fromARGB(255, 36, 105, 255),
//                         Color.fromARGB(255, 214, 19, 204),
//                       ],
//                     ),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       'Login',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 25),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 right: 190,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 40),
//                 child: Container(
//                   child: const Text(
//                     "Don't have an account",
//                     style: TextStyle(
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 60),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   Register()), // Navigate to Register screen
//                         );
//                       },
//                       child: const Text(
//                         'Sign up',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color.fromARGB(255, 7, 83, 145),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 120),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Forget(),
//                             ));
//                       },
//                       child: const Text(
//                         'Forget Password',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color.fromARGB(255, 7, 83, 145),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:movemate_ui/main_pages/Forget.dart';
import 'package:movemate_ui/navigation_view.dart';
import 'package:movemate_ui/navigation_view2.dart';
import 'register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class login extends StatefulWidget {
  login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool PasswordHidden = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = ''; // Variable to store error messages

  // Function to make API request to Django for login
  Future<void> loginUser(String username, String password) async {
    setState(() {
      _isLoading = true;
      _errorMessage = ''; // Reset the error message before sending the request
    });

    try {
      final response = await http.post(
        Uri.parse('https://e50b-45-243-12-201.ngrok-free.app/api/auth/login/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extract role, handling nested data structures if needed
        final role = data[
            'role']; // Adjust this based on your backend's response structure
        print('Parsed role: $role');

        if (role == null) {
          setState(() {
            _errorMessage = 'Role is missing in the response from the backend.';
          });
          return;
        }

        // Navigate based on the role
        if (role.toLowerCase() == 'delivery_person') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigation_view2()),
          );
        } else if (role.toLowerCase() == 'shipment_tracker') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigation_view()),
          );
        } else {
          setState(() {
            _errorMessage = 'Unhandled role: $role';
          });
        }
      } else {
        final errorData = json.decode(response.body);
        setState(() {
          _errorMessage =
              errorData['detail'] ?? 'Invalid username or password.';
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
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Shipment Tracking',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff44174E),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: 200,
                  height: 200,
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
                image: AssetImage('assets/images/Login.png'),
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
                    labelText: 'Username',
                    labelStyle: const TextStyle(color: Colors.blue),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 25, right: 10),
                      child: Icon(Icons.person),
                    ),
                    prefixIconColor: Colors.purple,
                    hintText: 'Enter your Username',
                    hintStyle: const TextStyle(color: Colors.purple),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
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
                  obscureText: PasswordHidden,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: Icon(PasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          PasswordHidden = !PasswordHidden;
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
                      borderSide: const BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            // Error message display
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: () {
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  loginUser(username, password);
                },
                child: Container(
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
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 190,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  child: const Text(
                    "Don't have an account",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Register()), // Navigate to Register screen
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 7, 83, 145),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 120),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Forget(),
                            ));
                      },
                      child: const Text(
                        'Forget Password',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 7, 83, 145),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
