import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/Reset_pass_AR.dart';
import 'package:gat_helper_app/features/common/sign_up_page.dart';

import 'Parent_home_pageAR.dart';
import 'Sign_up_page_AR.dart';
import '../../common/login_page.dart';

class LoginPageAR extends StatefulWidget {
  const LoginPageAR({super.key});

  @override
  State<LoginPageAR> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageAR> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl, // Ensure RTL alignment
      child: Scaffold(
        body: Stack(
          children: [
            // Background Decorations
            Positioned(
              top: -screenHeight * 0.10,
              left: -screenWidth * 0.8,
              right: -screenWidth * 0.8,
              child: Image.asset(
                'assets/img_12.png',
                fit: BoxFit.cover,
                width: screenWidth * 2.4,
                height: screenHeight * 0.40,
              ),
            ),
            Positioned(
              bottom: screenHeight * 0,
              left: -screenWidth * 0.1,
              right: -screenWidth * 0.1,
              child: Image.asset(
                'assets/img_11.png',
                fit: BoxFit.cover,
                width: screenWidth * 1.2,
                height: screenHeight * 0.4,
              ),
            ),
            Positioned(
              bottom: 0,
              left: -screenWidth * 0.1,
              right: -screenWidth * 0.1,
              child: Image.asset(
                'assets/img_10.png',
                fit: BoxFit.cover,
                width: screenWidth * 1.2,
                height: screenHeight * 0.35,
              ),
            ),
            Positioned(
              bottom: -screenHeight * 0.12,
              left: -screenWidth * 0.1,
              right: -screenWidth * 0.1,
              child: Image.asset(
                'assets/img_9.png',
                fit: BoxFit.cover,
                width: screenWidth * 1.2,
                height: screenHeight * 0.3,
              ),
            ),

            // زر الرجوع
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => SignUpPageAR(userRole: 'parent',)),);
                  },
                ),
              ),
            ),

            // المحتوى الرئيسي
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 30.0),

                      Center(
                        child: Text(
                          "مرحبا بعودتك!",
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.w600,
                            //height: -3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 35.0),

                      // إدخال البريد الإلكتروني
                      const Text(
                        'البريد الإلكتروني',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 5.0), // Top padding
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: ' أدخل بريدك الإلكتروني',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                        ),
                      ),
                      const SizedBox(height: 4.0), // Bottom padding

                      // إدخال كلمة المرور
                      const Text(
                        'كلمة المرور',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 5.0), // Top padding
                      TextFormField(
                        obscureText: true, // This will hide the password text
                        decoration: InputDecoration(
                          hintText: ' أدخل كلمة المرور',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                        ),
                      ),
                      const SizedBox(height: 4.0), // Bottom padding

                      const SizedBox(height: 15.0),

                      // زر تسجيل الدخول
                      Center(
                        child: SizedBox(
                          height: 48.0,
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ParentHomePageAR()),);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      //رابط
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "نسيت كلمة المرور؟ ",
                            style: const TextStyle(color: Colors.black87),
                            children: [
                              TextSpan(
                                text: 'تغيير كلمة المرور',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.lightBlue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const ResetPassAR(),
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Language Toggle Button, show only for Parent Role
            //if (widget.userRole == 'parent')
              Positioned(
                bottom: screenHeight * 0.15, // Adjusted to bring it closer to the bottom
                left: screenWidth * 0.40,    // Centered horizontally
                child: Center(
                  child: IconButton(
                    icon: Image.asset('assets/img_18.png', width: 40, height: 40), // Smaller size
                    iconSize: 40, // Smaller size
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginPage(userRole: 'parent')),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
