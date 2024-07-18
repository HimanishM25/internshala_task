import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../domain/internship.dart';
import 'details_page.dart';

class InternshipCard extends StatelessWidget {
  final Internship internship;

  InternshipCard({required this.internship});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              child: Text(
                internship.title,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Text(
              internship.duration,
              style: GoogleFonts.interTight(
                  fontSize: 14,
                  fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              internship.companyName,
              style: GoogleFonts.interTight(
                  fontSize: 14,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Stipend: ${internship.stipend}',
              style: GoogleFonts.interTight(fontSize: 12),
            ),
            SizedBox(height: 4),
            Text(
              'Location: ${internship.location}',
              style: GoogleFonts.interTight(fontSize: 12),
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


