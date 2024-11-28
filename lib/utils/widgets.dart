import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shihas_noviindus/Models/treatmentCardModel.dart';
import 'package:shihas_noviindus/Providers/patientProvider.dart';

import '../Models/TreatmentModel.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({
    Key? key,
    required this.name,
    required this.treatment,
    required this.date,
    required this.agent,
  }) : super(key: key);

  final String name;
  final String treatment;
  final String date;
  final String agent;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(64, 217, 217, 217),
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              treatment,
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Row(
                  children: [
                    // SvgPicture.asset('assets/calendar.svg', width: 20, height: 20),
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.red,
                    ),
                    Text(
                      date,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF006837),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 55),
                    const Icon(
                      Icons.people,
                      color: Colors.red,
                    ),
                    Text(
                      agent,
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "View Booking details",
                  style: GoogleFonts.poppins(
                      // fontWeight: FontWeight.bold,
                      ),
                ),
                const Icon(Icons.arrow_forward_ios_sharp)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final VoidCallback? onTapSuffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.label,
    this.keyboardType,
    this.controller,
    this.onChanged,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              filled: true,
              fillColor: const Color.fromARGB(64, 217, 217, 217),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                      onTap: onTapSuffixIcon,
                      child: suffixIcon,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final TreatmentCard treatmentCard;

  const PackageCard({
    Key? key,
    required this.treatmentCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  treatmentCard.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: treatmentCard.onDelete,
                ),
              ],
            ),
            // Male and Female count section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCountSection(
                  'Male',
                  treatmentCard.maleCount,
                  const Color.fromRGBO(0, 104, 55, 1.0),
                ),
                _buildCountSection(
                  'Female',
                  treatmentCard.femaleCount,
                  const Color.fromRGBO(0, 104, 55, 1.0),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Color.fromRGBO(0, 104, 55, 1.0),
                  ),
                  onPressed: treatmentCard.onEdit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountSection(String label, int count, Color color) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class AddTreatmentDialog extends StatefulWidget {
  @override
  _AddTreatmentDialogState createState() => _AddTreatmentDialogState();
}

class _AddTreatmentDialogState extends State<AddTreatmentDialog> {
  // Declare the controllers to control the patient counts
  int maleCount = 0;
  int femaleCount = 0;

  @override
  void initState() {
    super.initState();
    // Fetch the patient list when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientProvider>(context, listen: false).getTreatments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PatientProvider>(context);

    return AlertDialog(
      // title: const Text('Choose Treatment'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for choosing treatment
            Text(
              'Treatment',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            DropdownButtonFormField<Treatment>(
              decoration: InputDecoration(
                labelText: 'Select branch',
                border: OutlineInputBorder(),
              ),
              items: provider.treatmentList
                  .map((treat) => DropdownMenuItem<Treatment>(
                        value:
                            treat, // Set the value as the whole Treatment object
                        child: Text(treat?.name ?? ''), // Display the name
                      ))
                  .toList(),
              onChanged: (value) {
                provider.selectedTreatment = value?.name;
                provider.selectedTreatmentId = value?.id;
              },
            ),
            const SizedBox(height: 20),

            // Text for Add Patients
            const Text('Add Patients'),

            // Male Patient count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Male'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (maleCount > 0) maleCount--;
                        });
                      },
                    ),
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text(maleCount.toString()),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          maleCount++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Female Patient count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Female'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (femaleCount > 0) femaleCount--;
                        });
                      },
                    ),
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text(femaleCount.toString()),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          femaleCount++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              await provider.saveTreatment(
                TreatmentCard(
                    maleCount: maleCount,
                    femaleCount: femaleCount,
                    id: provider.selectedTreatmentId!,
                    name: provider.selectedTreatment!,
                    onEdit: () {},
                    onDelete: () {}),
              );
            },
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.78, horizontal: 8.52),
              backgroundColor: const Color(0xFF006837), // Primary button color
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.52)),
              ),
            ),
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
