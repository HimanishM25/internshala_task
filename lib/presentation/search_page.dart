import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/data_provider.dart';
import '../domain/internship.dart';
import 'details_card.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Internship> internships = [];
  List<Internship> filteredInternships = [];
  String selectedProfileFilter = 'All';
  String selectedLocationFilter = 'All';
  String selectedDurationFilter = 'All';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

Future<void> fetchData() async {
  setState(() {
    isLoading = true;
  });
  try {
    internships.clear();
    filteredInternships.clear();

    final data = await DataProvider.fetchData();
    final internshipsMeta = data['internships_meta'] as Map<String, dynamic>;

    internshipsMeta.forEach((key, value) {
      var type = value['type'] ?? 'Type not specified';
      switch (type) {
        case 'regular':
          type = 'In office';
          break;
        case 'virtual':
          type = 'Remote';
          break;
        default:
          type = 'Not mentioned';
      }

      internships.add(Internship(
        profile: value['profile_name'] ?? 'Profile not specified',
        duration: value['duration'] ?? 'Duration not specified',
        title: value['title'],
        companyName: value['company_name'],
        stipend: value['stipend'] != null ? value['stipend']['salary'] : 'Not provided',
        location: value['locations'] != null && value['locations'].isNotEmpty ? value['locations'][0]['string'] : 'Location not specified',
        type: type,
        postedOn: value['posted_on'] ?? 'Not specified',
        applyBy: value['expiring_in'] ?? 'Not specified',
        startDate: value['start_date'] ?? 'Not specified',
      ));
    });

    filterInternships();
  } catch (e) {
    print('Error fetching data: $e');
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

  void filterInternships() {
    filteredInternships = internships.where((internship) {
      final profileCondition = selectedProfileFilter == 'All' || internship.profile == selectedProfileFilter;
      final locationCondition = selectedLocationFilter == 'All' || internship.location == selectedLocationFilter;
      final durationCondition = selectedDurationFilter == 'All' || internship.duration == selectedDurationFilter;
      return profileCondition && locationCondition&& durationCondition;
    }).toList();
    setState(() {});
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(
        'Internships',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blueAccent,
    ),
    floatingActionButton: FloatingActionButton(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blueAccent,
      onPressed: () {
        showFilterOptions(context);
      },
      child: Icon(Icons.filter_alt_sharp),
    ),
    body: RefreshIndicator(
      onRefresh: () async {
        await fetchData();
      },
      child: isLoading
          ? Center(child: Text("Loading..."))
          : Container(
              padding: EdgeInsets.all(16),
              child: filteredInternships.isEmpty
                  ? (selectedProfileFilter != 'All' || selectedLocationFilter != 'All' || selectedDurationFilter != 'All')
                      ? Center(child: Text("No results found"))
                      : Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredInternships.length,
                      itemBuilder: (context, index) {
                        final internship = filteredInternships[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: InternshipCard(internship: internship),
                        );
                      },
                    ),
            ),
    ),
  );
}

void showFilterOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Profile'),
              trailing: selectedProfileFilter != 'All' ? const Icon(Icons.check) : null,
              onTap: () {
                Navigator.pop(context);
                showProfileFilterOptions(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('Duration'),
              trailing: selectedDurationFilter != 'All' ? const Icon(Icons.check) : null,
              onTap: () {
                Navigator.pop(context);
                showDurationFilterOptions(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location'),
              trailing: selectedLocationFilter != 'All' ? const Icon(Icons.check) : null,
              onTap: () {
                Navigator.pop(context);
                showLocationFilterOptions(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.clear, color: Colors.red),
              title: Text('Clear Filters'),
              onTap: () {
                Navigator.pop(context);
                clearFilters();
              },
            ),
          ],
        ),
      );
    },
  );
}

  void showProfileFilterOptions(BuildContext context) {
    final Set<String> profileOptions = {'All'};
    internships.forEach((internship) {
      profileOptions.add(internship.profile);
    });

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView(
            shrinkWrap: true,
            children: profileOptions.map((option) {
              return ListTile(
                title: Text(option),
                trailing: selectedProfileFilter == option ? const Icon(Icons.check) : null,
                onTap: () {
                  Navigator.pop(context);
                  selectedProfileFilter = option;
                  filterInternships();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
  void showDurationFilterOptions(BuildContext context) {
    final Set<String> stipendOptions = {'All'};
    internships.forEach((internship) {
      stipendOptions.add(internship.duration);
    });

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView(
            shrinkWrap: true,
            children: stipendOptions.map((option) {
              return ListTile(
                title: Text(option),
                trailing: selectedDurationFilter == option ? const Icon(Icons.check) : null,
                onTap: () {
                  Navigator.pop(context);
                  selectedDurationFilter = option;
                  filterInternships();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

void showLocationFilterOptions(BuildContext context) {
  final Set<String> locationOptions = {'All'};
  internships.forEach((internship) {
    locationOptions.add(internship.location);
  });

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: ListView(
          shrinkWrap: true,
          children: locationOptions.map((option) {
            return ListTile(
              title: Text(option),
              trailing: selectedLocationFilter == option ? const Icon(Icons.check) : null,
              onTap: () {
                Navigator.pop(context);
                selectedLocationFilter = option;
                filterInternships();
              },
            );
          }).toList(),
        ),
      );
    },
  );
}

  void clearFilters() {
    selectedProfileFilter = 'All';
    selectedLocationFilter = 'All';
    selectedDurationFilter = 'All';
    filterInternships();
  }
}