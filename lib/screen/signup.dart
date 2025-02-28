import 'package:flutter/material.dart';
import 'package:hamdiappps/theme/theme.dart';
import 'package:hamdiappps/widgets/custom_scaffold.dart';
import 'package:hamdiappps/screen/signin.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formSignupKey = GlobalKey<FormState>();
  bool agreePersonalData = true;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(height: 10),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      _buildTextField('Full Name', 'Enter Full Name', (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Full name';
                        }
                        return null;
                      }),
                      const SizedBox(height: 25.0),
                      _buildTextField('Email', 'Enter Email', (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        return null;
                      }),
                      const SizedBox(height: 25.0),
                      _buildTextField('Password', 'Enter Password', (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      }, obscureText: true),
                      const SizedBox(height: 25.0),
                      Row(
                        children: [
                          Checkbox(
                            value: agreePersonalData,
                            onChanged: (bool? value) {
                              setState(() {
                                agreePersonalData = value!;
                              });
                            },
                            activeColor: lightColorScheme.primary,
                          ),
                          const Text('I agree to the processing of '),
                          Text(
                            'Personal data',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: lightColorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onSignupPressed,
                          child: const Text('Sign up'),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildDivider('Sign up with'),
                      const SizedBox(height: 30.0),
                      _buildSigninNavigation(),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, String? Function(String?) validator,
      {bool obscureText = false}) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black26),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _onSignupPressed() {
    if (_formSignupKey.currentState!.validate() && agreePersonalData) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    } else if (!agreePersonalData) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please agree to the processing of personal data')),
      );
    }
  }

  Widget _buildDivider(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child:
                Divider(thickness: 0.7, color: Colors.grey.withOpacity(0.5))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(text, style: const TextStyle(color: Colors.black45)),
        ),
        Expanded(
            child:
                Divider(thickness: 0.7, color: Colors.grey.withOpacity(0.5))),
      ],
    );
  }

  Widget _buildSigninNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account? ',
            style: TextStyle(color: Colors.black45)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Signin()));
          },
          child: Text(
            'Sign in',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: lightColorScheme.primary),
          ),
        ),
      ],
    );
  }
}
