class Internship {
  final int id;
  final String title;
  final String employmentType;
  final bool workFromHome;
  final String companyName;
  final String employerName;
  final String companyLogo;
  final String expiresAt;
  final String startDate;
  final String duration;
  final List<String> locations;

  Internship({
    required this.id,
    required this.title,
    required this.employmentType,
    required this.workFromHome,
    required this.companyName,
    required this.employerName,
    required this.companyLogo,
    required this.expiresAt,
    required this.startDate,
    required this.duration,
    required this.locations,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    List<String> locations = [];
    if (json['locations'] != null) {
      json['locations'].forEach((v) {
        locations.add(v['string']);
      });
    }
    return Internship(
      id: json['id'],
      title: json['title'],
      employmentType: json['employment_type'],
      workFromHome: json['work_from_home'],
      companyName: json['company_name'],
      employerName: json['employer_name'],
      companyLogo: json['company_logo'],
      expiresAt: json['expires_at'],
      startDate: json['start_date'],
      duration: json['duration'],
      locations: locations,
    );
  }
}