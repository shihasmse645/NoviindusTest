import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shihas_noviindus/Views/register.dart';
import 'package:shihas_noviindus/utils/widgets.dart';

import '../Providers/patientProvider.dart';

class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  State<PatientList> createState() => _PatientListState();
}

String _selectedSortOption = 'Date';

class _PatientListState extends State<PatientList> {
  @override
  void initState() {
    super.initState();
    // Fetch the patient list when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientProvider>(context, listen: false).getPatientList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    return Scaffold(
      floatingActionButton: Container(
        width: double.infinity, // Make the button take full width
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            // Handle Register button click
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegistrationPage()));
          },
          backgroundColor: const Color(0xFF006837),
          child: Text(
            "Register Now",
            style: GoogleFonts.poppins(
              color: Colors.white, // Text color
              fontSize: 14, // Font size from Figma
              fontWeight: FontWeight.w500, // Font weight from Figma
              height: 18 / 12, // Line height as per Figma
              letterSpacing: 0.01, // letter-spacing from Figma
            ),
          ), // Background color for the button
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // Docked at the bottom center

      body: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Notifications clicked')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Expanded TextField to make it flexible within the row
                    Expanded(
                      child: SizedBox(
                        height: 40, // Set height as per Figma
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Search for Treatment',
                            labelStyle: GoogleFonts.poppins(
                              fontSize: 12, // Font size from Figma
                              fontWeight:
                                  FontWeight.w500, // Font weight from Figma
                              height: 18 / 12, // Line height as per Figma
                              letterSpacing: 0.01, // letter-spacing from Figma
                            ), // Label text
                            prefixIcon: const Icon(Icons.search), // Search icon
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  8.53), // Rounded corners
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width:
                            10), // Gap between search field and search button
                    // SizedBox for the fixed-width button
                    SizedBox(
                      width: 80, // Adjust width of the button as needed
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF006837), // Primary button color
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.52)),
                          ),
                        ),
                        onPressed: () {
                          // Handle the search action
                        },
                        child: Text(
                          'Search',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12, // Font size from Figma
                            fontWeight:
                                FontWeight.w500, // Font weight from Figma
                            height: 18 / 12, // Line height as per Figma
                            letterSpacing: 0.01, // letter-spacing from Figma
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sort By:",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12, // Font size from Figma
                      fontWeight: FontWeight.w500, // Font weight from Figma
                      height: 18 / 12, // Line height as per Figma
                      letterSpacing: 0.01, // letter-spacing from Figma
                    ),
                  ),
                  Container(
                    width: 169, // Fixed width
                    height: 39, // Fixed height
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0), // Padding
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(33)),
                      border: Border.all(
                        color: Colors
                            .black, // All sides have the same border color
                        width: 1.0, // Border width for all sides
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedSortOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSortOption = newValue!;
                        });
                      },
                      items: <String>['Date', 'Name']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text("Select Sort Option"),
                      isExpanded:
                          true, // Ensures the dropdown takes the full width of the container
                      underline: Container(), // Removes the underline
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            // const PatientCard(
            //   name: 'Vikram Singh',
            //   package: 'Couple Combo Package (Rejuvenate Getaway)',
            //   date: '31/01/2024',
            //   agent: 'Jithesh',
            // )
            Expanded(
              child: patientProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : patientProvider.errorMessage.isNotEmpty
                      ? Center(
                          child: Text(
                            patientProvider.errorMessage,
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: patientProvider.patientList.length,
                          itemBuilder: (context, index) {
                            final patient = patientProvider.patientList[index];
                            return PatientCard(
                              name: patient.name.toString(),
                              treatment: patient
                                  .patientdetailsSet!.first.treatmentName
                                  .toString(),
                              date: DateFormat('dd/MM/yyyy').format(
                                  patient.dateNdTime ?? DateTime(2000, 1, 1)),
                              // date: patient.dateNdTime,
                              agent: patient.user.toString(),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
