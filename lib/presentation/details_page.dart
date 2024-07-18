import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../domain/internship.dart';

class InternshipDetailsPage extends StatelessWidget {
  final Internship internship;

  InternshipDetailsPage({required this.internship});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  toolbarHeight: 180,
  backgroundColor: Colors.transparent,
  centerTitle: true,
  leading: SizedBox(),
  flexibleSpace: Stack(
    children: [
      Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[900]!, Colors.lightBlue],
          ),
        ),
      ),
      Positioned(
        child:  IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white), // Set the back arrow icon
        onPressed: () => Navigator.pop(context), // Go back on press
      ),
      top: 25,
      left: 10,
      ),
      Positioned(
        bottom: 10,
        left: 10,
        child:
        Text(
          internship.title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    ],
  ),
  elevation: 0,
),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.factory),
                SizedBox(width: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.5,
                  ),
                  child: Text(
                    internship.companyName,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Spacer(),
                Icon(Icons.access_time),
                SizedBox(width: 8),
                Text(
                  internship.duration,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Text("Stipend: ",

                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${internship.stipend}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text("Location: ",

                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${internship.location}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text("Type: ",

                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                 '${internship.type}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text("Posted On: ",

                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${internship.postedOn}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              '${internship.startDate}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${internship.applyBy}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

