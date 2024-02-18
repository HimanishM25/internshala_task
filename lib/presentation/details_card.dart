import 'package:flutter/material.dart';
import '../domain/internship.dart';
import 'details_page.dart';

class InternshipCard extends StatelessWidget {
  final Internship internship;

  InternshipCard({required this.internship});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          internship.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              internship.companyName,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Stipend: ${internship.stipend}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              'Location: ${internship.location}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InternshipDetailsPage(internship: internship)),
          );
        },
      ),
    );
  }
}


