import 'package:flutter/material.dart';

import 'Reset_pass_page.dart';

class EditProfilePage extends StatefulWidget {
  final String role;
  final Map<String, dynamic> initialData;

  EditProfilePage({required this.role, required this.initialData});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String? selectedGender;
  String? selectedGrade;
  double tutorRating = 0.0; // Default rating (will be updated)

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialData['name']);
    emailController = TextEditingController(text: widget.initialData['email']);
    passwordController = TextEditingController(text: widget.initialData['password']);
    selectedGender = widget.initialData['gender'];
    selectedGrade = widget.initialData['grade'];

    if (widget.role == 'tutor') {
      tutorRating = widget.initialData['rating'] ?? 0.0; // Fetch rating from data
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
      if (widget.role == 'tutor') 'rating': tutorRating, // Save updated rating
    };
    print('Saved Data: $updatedData');
  }
  // Function to create star icons based on rating
  Widget buildStarRating(double rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border, // Filled or empty star
          color: Colors.amber,
          size: 30,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background Image
            SizedBox(
              width: screenWidth,
              height: 200,
              child: Image.asset(
                'assets/img_25.png',
                fit: BoxFit.cover,
              ),
            ),

            // Profile Avatar
            Transform.translate(
              offset: Offset(0, -50),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_placeholder.png'),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Change Picture',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  // Tutor Rating Section
                  if (widget.role == 'tutor') ...[
                    SizedBox(height: 5),
                    buildStarRating(tutorRating), // Display star rating
                    SizedBox(height: 10),
                  ],
                ],
              ),
            ),

            // Form Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),

                  SizedBox(height: 12),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),

                  SizedBox(height: 12),

                  // Password Field with Pencil Icon
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                          enabled: false, // Make it non-editable
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ResetPassWidget()),
                          );
                        },
                      ),
                    ],
                  ),

                  if (widget.role == 'student') ...[
                    SizedBox(height: 12),
                    DropdownButtonFormField(
                      value: selectedGrade,
                      decoration: InputDecoration(labelText: 'Grade level'),
                      items: ['12', '11', '10']
                          .map((grade) => DropdownMenuItem(value: grade, child: Text(grade)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedGrade = value as String?;
                        });
                      },
                    ),
                  ],

                  SizedBox(height: 12),
                  DropdownButtonFormField(
                    value: selectedGender,
                    decoration: InputDecoration(labelText: 'Gender'),
                    items: ['Male', 'Female']
                        .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value as String?;
                      });
                    },
                  ),

                  SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: screenWidth * 0.8, // Make button longer
                      child: ElevatedButton(
                        onPressed: saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Save', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


