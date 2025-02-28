import 'package:flutter/material.dart';
import '../auth/views/Reset_pass_AR.dart';
import 'Reset_pass_page.dart';

class EditProfilePageAR extends StatefulWidget {
  final String role;
  final Map<String, dynamic> initialData;

  EditProfilePageAR({required this.role, required this.initialData});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePageAR> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String? selectedGender;
  String? selectedGrade;
  double tutorRating = 0.0;

  List<Map<String, String>> childrenList = [
    {'name': 'أحمد علي', 'avatar': 'assets/profile_placeholder.png'},
    {'name': 'سارة محمد', 'avatar': 'assets/profile_placeholder.png'},
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialData['name']);
    emailController = TextEditingController(text: widget.initialData['email']);
    passwordController = TextEditingController(text: widget.initialData['password']);
    selectedGender = widget.initialData['gender'];
    selectedGrade = widget.initialData['grade'];

    if (widget.role == 'tutor') {
      tutorRating = widget.initialData['rating'] ?? 0.0;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void saveChanges() {
    final updatedData = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'gender': selectedGender,
      if (widget.role == 'student') 'grade': selectedGrade,
      if (widget.role == 'tutor') 'rating': tutorRating,
    };
    print('تم حفظ البيانات: $updatedData');
  }

  Widget buildStarRating(double rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 30,
        );
      }),
    );
  }

  void deleteChild(int index) {
    setState(() {
      childrenList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 170,
                width: screenWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img_25.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, right: 16),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -50),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile_placeholder.png'),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      child: Text('تغيير الصورة', style: TextStyle(fontSize: 16)),
                    ),
                    if (widget.role == 'tutor') ...[
                      SizedBox(height: 5),
                      buildStarRating(tutorRating),
                      SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(0, -50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'الاسم'),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(labelText: 'كلمة المرور'),
                              enabled: false,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ResetPassAR()),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      DropdownButtonFormField(
                        value: selectedGender,
                        decoration: InputDecoration(labelText: 'الجنس'),
                        items: ['ذكر', 'أنثى']
                            .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value as String?;
                          });
                        },
                      ),
                        SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                              'أبنائي',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),),
                        SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerRight, // Aligns the entire Wrap to the right
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: List.generate(childrenList.length, (index) {
                            final child = childrenList[index];
                            return Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                width: 120,
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(child['avatar']!),
                                    ),
                                    SizedBox(height: 8),
                                    Text(child['name']!, style: TextStyle(fontSize: 14)),
                                    SizedBox(height: 8),
                                    IconButton(
                                      icon: Icon(Icons.close, color: Colors.red),
                                      onPressed: () => deleteChild(index),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: screenWidth * 0.8,
                          child: ElevatedButton(
                            onPressed: saveChanges,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('حفظ', style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}