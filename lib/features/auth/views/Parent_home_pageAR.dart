import 'package:flutter/material.dart';
import 'package:gat_helper_app/features/auth/views/AR_dashboard.dart';
import 'package:gat_helper_app/features/common/edit_profile_page.dart';
import '../../common/edit_profileAR_page.dart';
import 'Parent_home_page.dart';
import 'Parent_home_pageAR.dart';
import '../../common/login_page.dart';
import 'login_page_AR.dart';

class ParentHomePageAR extends StatefulWidget {
  const ParentHomePageAR({super.key});

  @override
  _ParentHomePageARState createState() => _ParentHomePageARState();
}

class _ParentHomePageARState extends State<ParentHomePageAR> {
  bool isNotificationEnabled = false;

  // List of children with their connection request status
  List<Map<String, String>> children = [
    {"name": "نورة عمر", "icon": "assets/img_21.png", "status": "تم الموافقة"},
    {"name": "هدى عمر", "icon": "assets/img_22.png", "status": "معلق"},
    {"name": "علي سعد", "icon": "assets/img_23.png", "status": "مرفوض"},
  ];

  // List for children whose connection has been approved
  List<Map<String, String>> approvedChildren = [];

  // List for children whose connection is pending or declined
  List<Map<String, String>> pendingChildren = [];

  // Dynamic parent data (these would come from a database or authentication system)
  String parentName = "عمر سعد"; // Replace with dynamic data
  String parentEmail = "omar.saad@example.com"; // Replace with dynamic data
  String parentAvatar = "assets/img_20.png"; // Replace with dynamic data

  @override
  void initState() {
    super.initState();
    // Separate children into approved and pending lists
    _separateChildrenByStatus();
  }

  // Method to separate children based on their status
  void _separateChildrenByStatus() {
    approvedChildren.clear();
    pendingChildren.clear();

    for (var child in children) {
      if (child["status"] == "تم الموافقة") {
        approvedChildren.add(child);
      } else if (child["status"] == "معلق" || child["status"] == "مرفوض") {
        pendingChildren.add(child);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 250,
              width: 500,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF284379),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(parentAvatar), // Dynamic Avatar
                    ),
                    const SizedBox(height: 10),
                    Text(
                      parentName, // Dynamic Name
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      parentEmail, // Dynamic Email
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.black),
              title: const Text('تعديل الملف الشخصي'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePageAR(role: 'parent', initialData: {}),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Colors.black),
              title: const Text('اتصل بنا'),
              onTap: () {
                _showContactUsDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('تسجيل الخروج'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPageAR(userRole: 'parent'),
                  ),
                );
              },
            ),
            const Spacer(),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(right: 85.5),
                child: Image.asset(
                  'assets/img_18.png',
                  width: 40,
                  height: 40,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const ParentHomePage()), // Switch to the Arabic page
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/img_23.png",
              fit: BoxFit.cover,
              height: 380,
              width: screenWidth,
            ),
          ),
          Positioned(
            top: 20,
            right: 10,
            child: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black, size: 30),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
          Column(
            children: [
              _buildProfileHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 60),
                        _buildChildrenSection(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "ارتباط الابناء",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
                              onPressed: () {
                                _showAddChildDialog();
                              },
                            ),
                          ],
                        ),
                        _buildConnectionRequests(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),);

  }

  void _showContactUsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("تواصل معنا", textAlign: TextAlign.center),
          content: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "إذا كانت لديك أي أسئلة، لا تتردد في الاتصال بنا على:\n\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "GAThelper@gmail.com\n\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const TextSpan(
                  text: "نحن هنا للمساعدة!",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("إغلاق"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(height: 80),
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(parentAvatar), // Dynamic Avatar
          ),
          const SizedBox(height: 10),
          const Text(
            "مرحباً",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Text(
            parentName, // Dynamic Name
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildChildrenSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle("أبنائي"),
            IconButton(
              icon: Icon(
                isNotificationEnabled ? Icons.notifications_on : Icons.notifications_off,
                color: isNotificationEnabled ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isNotificationEnabled = !isNotificationEnabled;
                });
              },
            ),
          ],
        ),
        Column(
          children: approvedChildren.map((child) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                leading: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(child["icon"]!),
                ),
                title: Text(
                  child["name"]!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ARDashboard(),
                      ),
                    );
                  },
                  child: const Icon(Icons.bar_chart, color: Colors.grey),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConnectionRequests() {
    return pendingChildren.isEmpty
        ? Center(
      child: Text(
        "لا توجد طلبات اتصال",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    )
        : Column(
      children: pendingChildren.map((child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0), // Add space between cards
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 3,
            child: ListTile(
              title: Text(
                child["name"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("بريد الطفل الإلكتروني"),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: child["status"] == "معلق" ? Colors.yellow : (child["status"] == "تم الموافقة" ? Colors.green : Colors.red),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  child["status"]!,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showAddChildDialog() {
    final TextEditingController emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("إضافة ابن"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("أدخل البريد الإلكتروني لابنك"),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "البريد الإلكتروني",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("إلغاء"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("إضافة"),
              onPressed: () {
                setState(() {
                  children.add({"name": emailController.text, "icon": "assets/img_20.png", "status": "معلق"});
                  _separateChildrenByStatus();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
