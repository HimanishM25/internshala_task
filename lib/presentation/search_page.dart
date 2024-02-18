import 'package:flutter/material.dart';
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
  String selectedStipendFilter = 'All';
  String selectedLocationFilter = 'All';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await DataProvider.fetchData();
      final internshipsMeta = data['internships_meta'] as Map<String, dynamic>;

      internshipsMeta.forEach((key, value) {
        internships.add(Internship(
          title: value['title'],
          companyName: value['company_name'],
          stipend: value['stipend'] != null ? value['stipend']['salary'] : 'Not provided',
          location: value['locations'] != null && value['locations'].isNotEmpty ? value['locations'][0]['string'] : 'Location not specified',
        ));
      });

      filterInternships();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void filterInternships() {
    filteredInternships = internships.where((internship) {
      final stipendCondition = selectedStipendFilter == 'All' || internship.stipend == selectedStipendFilter;
      final locationCondition = selectedLocationFilter == 'All' || internship.location == selectedLocationFilter;
      return stipendCondition && locationCondition;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Internships',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showFilterOptions(context);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: filteredInternships.isEmpty
            ? Center(child: CircularProgressIndicator())
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
                title: Text('Stipend'),
                onTap: () {
                  Navigator.pop(context);
                  showStipendFilterOptions(context);
                },
              ),
              ListTile(
                title: Text('Location'),
                onTap: () {
                  Navigator.pop(context);
                  showLocationFilterOptions(context);
                },
              ),
              ListTile(
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

  void showStipendFilterOptions(BuildContext context) {
    final Set<String> stipendOptions = {'All'};
    internships.forEach((internship) {
      stipendOptions.add(internship.stipend);
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
                onTap: () {
                  Navigator.pop(context);
                  selectedStipendFilter = option;
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
    selectedStipendFilter = 'All';
    selectedLocationFilter = 'All';
    filterInternships();
  }
}
