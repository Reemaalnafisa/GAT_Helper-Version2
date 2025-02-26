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

  // Sample children data for the parent
  List<Map<String, String>> childrenList = [
    {'name': 'John Doe', 'avatar': 'assets/profile_placeholder.png'},
    {'name': 'Jane Smith', 'avatar': 'assets/profile_placeholder.png'},
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

  // Function to delete a child from the list
  void deleteChild(int index) {
    setState(() {
      childrenList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView( // Make the whole page scrollable
        child: Column(
          children: [
            // Profile Section
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
                padding: const EdgeInsets.only(top: 40.0, left: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),

            // Profile Avatar Section
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

        // Form Fields Section
        Transform.translate(  // Apply translation to the entire form to move it up
          offset: Offset(0, -50),  // Adjust the value to move it up further
          child: Padding(
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                          enabled: false,
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
                  if (widget.role == 'parent') ...[
                    SizedBox(height: 12),
                    Text(
                      'Children',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Wrap(
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
                  ],
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
                        child: Text('Save', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
        ),],
        ),
      ),
    );
  }
}
