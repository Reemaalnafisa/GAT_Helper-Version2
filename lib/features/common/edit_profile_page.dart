import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialData['name']);
    emailController = TextEditingController(text: widget.initialData['email']);
    passwordController = TextEditingController(text: widget.initialData['password']);
    selectedGender = widget.initialData['gender'];
    selectedGrade = widget.initialData['grade'];
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
    };
    print('Saved Data: $updatedData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/profile_placeholder.png')),
            TextButton(onPressed: () {}, child: Text('Change Picture')),
            TextFormField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            if (widget.role == 'student')
              DropdownButtonFormField(
                value: selectedGrade,
                items: ['12', '11']
                    .map((grade) => DropdownMenuItem(value: grade, child: Text(grade)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGrade = value as String?;
                  });
                },
              ),
            TextFormField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextFormField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            DropdownButtonFormField(
              value: selectedGender,
              items: ['Male', 'Female']
                  .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value as String?;
                });
              },
            ),
            ElevatedButton(onPressed: saveChanges, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
