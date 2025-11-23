import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});


  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F7FC),
              Color(0xFFFBF9FF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),

                Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 18),
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 18,
                        offset: Offset(0, 8),
                      ),
                    ],
                    color: Colors.white.withOpacity(0.98),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipOval(
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/SVG/logo.svg',
                          fit: BoxFit.contain,

                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Create your positive space',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2340),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Sign up to receive daily mood-tailored quotes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8E92A6),
                  ),
                ),

                const SizedBox(height: 26),

                _buildInputCard(
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Color(0xFF1F2340), fontSize: 16),
                    decoration: const InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Color(0xFF8E92A6)),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF8E92A6)),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Password field
                _buildInputCard(
                  child: TextField(
                    controller: _passController,
                    obscureText: _obscurePass,
                    style: const TextStyle(color: Color(0xFF1F2340), fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Color(0xFF8E92A6)),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF8E92A6)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePass ? Icons.visibility_off : Icons.visibility,
                          color: const Color(0xFF8E92A6),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePass = !_obscurePass;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Confirm password field
                _buildInputCard(
                  child: TextField(
                    controller: _confirmController,
                    obscureText: _obscureConfirm,
                    style: const TextStyle(color: Color(0xFF1F2340), fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(color: Color(0xFF8E92A6)),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF8E92A6)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                          color: const Color(0xFF8E92A6),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirm = !_obscureConfirm;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C8EF5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      shadowColor: Colors.black.withOpacity(0.09),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: Color(0xFF8E92A6)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF6C8EF5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}
