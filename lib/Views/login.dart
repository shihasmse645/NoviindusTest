import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shihas_noviindus/Providers/loginprovider.dart';
import 'package:shihas_noviindus/Views/patientList.dart';
import 'package:shihas_noviindus/utils/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack with Background and Logo
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200, // Height for the image container
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/secImage.png'),
                      fit: BoxFit.cover, // Fills the container
                    ),
                  ),
                ),
                Image.asset(
                  'assets/icons/logo.png', // Logo image
                  height: 80, // Height for the logo
                  width: 80, // Width for the logo
                ),
              ],
            ),

            // Title Text
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text(
                "Login or register to book your appointments",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  height: 33.6 / 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Email Label and TextField

            CustomTextField(
              label: "Email",
              hintText: "Enter your email",
              controller: usernameController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
                } else if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
                  return "Enter a valid email";
                }
                return null;
              },
            ),

            CustomTextField(
              label: "Password",
              hintText: "Enter your password",
              controller: passwordController,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password is required";
                }
                return null;
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            // Login Button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: loginProvider.isLoading
                      ? null
                      : () async {
                          final success = await loginProvider.login(
                            usernameController.text.trim(),
                            passwordController.text.trim(),
                          );

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login Successful')),
                            );
                            // Navigate to nex
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientList()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(loginProvider.errorMessage)),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.78, horizontal: 8.52),
                    backgroundColor:
                        const Color(0xFF006837), // Primary button color
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.52)),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 18 / 12,
                    letterSpacing: 0.01,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          "By creating or logging into an account you are agreeing with our ",
                    ),
                    TextSpan(
                      text: "Terms and Conditions",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        height: 18 / 12,
                        letterSpacing: 0.01,
                        color: const Color(0xFF0028FC), // Blue color
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle Terms and Conditions click
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PatientList()));
                        },
                    ),
                    const TextSpan(
                      text: " and ",
                    ),
                    TextSpan(
                      text: "Privacy Policy",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        height: 18 / 12,
                        letterSpacing: 0.01,
                        color: const Color(0xFF0028FC), // Blue color
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle Privacy Policy click
                        },
                    ),
                    const TextSpan(
                      text: ".",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
