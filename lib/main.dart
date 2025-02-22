import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase Connection Successful");
  } catch (e) {
    print("❌ Firebase Initialization Failed: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Screen',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/loginnn.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Login',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.facebook, color: Colors.white),
                          label: const Text('FACEBOOK',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B5998),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.g_mobiledata, color: Colors.black87),
                          label: const Text('GOOGLE',
                              style: TextStyle(color: Colors.black87)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('LOGIN', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text('REGISTER HERE', style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Function to register user
  void registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Register user in Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Get the user ID
        String userId = userCredential.user!.uid;

        // Store user details in Firestore
        await FirebaseFirestore.instance.collection("users").doc(userId).set({
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
          "phone": _phoneController.text.trim(),
          "address": _addressController.text.trim(),
          "timestamp": FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful!')),
        );

        Navigator.pop(context); // Go back to Login Screen
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Create Your Account',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) =>
                  !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)
                      ? 'Enter a valid email'
                      : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) =>
                  value!.length < 6 ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.home),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your address' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: registerUser, // Call registerUser function
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('REGISTER', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Welcome to Home Screen!')),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
//       ),
//       home: const RegistrationForm(),
//     );
//   }
// }
//
// class RegistrationForm extends StatefulWidget {
//   const RegistrationForm({Key? key}) : super(key: key);
//
//   @override
//   _RegistrationFormState createState() => _RegistrationFormState();
// }
//
// class _RegistrationFormState extends State<RegistrationForm> {
// final _formKey = GlobalKey<FormState>();
// final _controllers = List.generate(5, (_) => TextEditingController());
// final _focusNodes = List.generate(5, (_) => FocusNode());
//
// @override
// void dispose() {
//   for (var controller in _controllers) {
//     controller.dispose();
//   }
//   for (var node in _focusNodes) {
//     node.dispose();
//   }
//   super.dispose();
// }
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFFE8F5E9), Colors.white],
//         ),
//       ),
//       child: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               floating: true,
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: Text(
//                   'Order Form',
//                   style: GoogleFonts.poppins(
//                     color: Colors.green[800],
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Please fill out the form to order',
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           color: Colors.green[800],
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       ..._buildFormFields(),
//                       const SizedBox(height: 32),
//                       _buildSubmitButton(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
//
// List<Widget> _buildFormFields() {
//   final labels = ['First Name', 'Last Name', 'Address', 'Landmark', 'Mobile Number'];
//   final icons = [Icons.person, Icons.person, Icons.home, Icons.location_on, Icons.phone];
//
//   return List.generate(
//     5,
//         (index) => Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: _controllers[index],
//         focusNode: _focusNodes[index],
//         decoration: _getInputDecoration(labels[index], icons[index]),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter ${labels[index].toLowerCase()}';  // Ensures the field is required
//           }
//           if (index == 4 && value.length != 10) {
//             return 'Mobile number must be 10 digits'; // Mobile number validation
//           }
//           return null;
//         },
//         onFieldSubmitted: (_) {
//           if (index < 4) {
//             FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
//           }
//         },
//         keyboardType: index == 4 ? TextInputType.phone : TextInputType.text,
//       ),
//     ),
//   );
// }
//
// InputDecoration _getInputDecoration(String label, IconData icon) {
//   return InputDecoration(
//     labelText: label,
//     prefixIcon: Icon(icon, color: Colors.green[800]),
//     labelStyle: TextStyle(color: Colors.green[800]),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: BorderSide(color: Colors.green[200]!),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: BorderSide(color: Colors.green[800]!, width: 2),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: BorderSide(color: Colors.red[400]!),
//     ),
//     focusedErrorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: BorderSide(color: Colors.red[400]!, width: 2),
//     ),
//     filled: true,
//     fillColor: Colors.white,
//   );
// }
//
// Widget _buildSubmitButton() {
//   return SizedBox(
//     width: double.infinity,
//     child: ElevatedButton(
//       onPressed: _submitForm,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.green[800],
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: Text(
//         'SUBMIT',
//         style: GoogleFonts.poppins(
//           color: Colors.white,
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     ),
//   );
// }
//
// void _submitForm() {
//   if (_formKey.currentState!.validate()) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'Registration Successful!',
//           style: GoogleFonts.poppins(),
//         ),
//         backgroundColor: Colors.green[800],
//       ),
//     );
//   }
// }
// }
