import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/common/login_page.dart';
import 'package:gat_helper_app/features/common/sign_up_page.dart';
import 'package:gat_helper_app/features/common/start_page.dart';

import 'login_page_AR.dart';

class SignUpPageAR extends StatefulWidget {
  final String userRole;
  const SignUpPageAR({super.key, required this.userRole});

  @override
  State<SignUpPageAR> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPageAR> {
  String? _selectedGender;
  final List<String> _items = ['ذكر', 'أنثى', 'آخر'];

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
                      MaterialPageRoute(builder: (_) => StartPage()),);
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
                          'أهلا وسهلا!',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            height: -7,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Center(
                        child: Text(
                          "دعنا نبدأ!",
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.w600,
                            height: -3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 35.0),


                      // إدخال الاسم
                      const Text(
                        'الاسم',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 5.0), // Top padding
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: ' أدخل اسمك',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                        ),
                      ),
                      const SizedBox(height: 4.0), // Bottom padding

                      //const SizedBox(height: 10.0),

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

                      //const SizedBox(height: 10.0),

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

                      //const SizedBox(height: 10.0),

                      // اختيار الجنس
                      const Text(
                        'الجنس',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 5.0), // Top padding
                      DropdownButtonFormField<String>(
                        value: _selectedGender,
                        decoration: InputDecoration(
                          hintText: ' اختر الجنس',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                        ),
                        items: _items.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),


                      const SizedBox(height: 15.0),

                      // زر التسجيل
                      Center(
                        child: SizedBox(
                          height: 48.0,
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'تسجيل',
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

                      // رابط تسجيل الدخول
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "لديك حساب بالفعل؟",
                            style: const TextStyle(color: Colors.black87),
                            children: [
                              TextSpan(
                                text: ' تسجيل الدخول',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.lightBlue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const LoginPageAR(),
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
            if (widget.userRole == 'parent')
              Positioned(
                bottom: screenHeight * 0.15, // Adjusted to bring it closer to the bottom
                left: screenWidth * 0.40,    // Centered horizontally
                child: Center(
                  child: IconButton(
                    icon: Image.asset('assets/img_18.png', width: 40, height: 40), // Smaller size
                    iconSize: 40, // Smaller size
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const SignUpPage(userRole: 'parent')),
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
