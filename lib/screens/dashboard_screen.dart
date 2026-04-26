import 'package:flutter/material.dart';
import 'package:saku/models/user_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =
        ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.blue.shade200],
                  ),
              ),
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.person, size: 40, color: Colors.white),
                  SizedBox(height: 10),
                  Text(user.name, 
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.lightBlueAccent,),
              title: Text("Dashboard"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

          ListTile(
            leading: Icon(Icons.logout, color: Colors.red,),
            title: Text("Logout", style: TextStyle(color: Colors.red),),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          )
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade200],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,)
        ),      
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat datang, ${user.name}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
            ),
            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.newspaper, color: Colors.lightBlueAccent,),
                      title: Text("Berita Saku ${index + 1}", style: TextStyle(color: Colors.lightBlueAccent),),
                      subtitle: Text("Deskripsi Berita"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
   );
  }
}