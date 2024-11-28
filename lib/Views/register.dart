import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shihas_noviindus/Models/treatmentCardModel.dart';
import 'package:shihas_noviindus/utils/widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../Providers/patientProvider.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

final _nameController = TextEditingController();
final _numberController = TextEditingController();
final _addressController = TextEditingController();
final _totalController = TextEditingController();
final _discountController = TextEditingController();
final _advanceController = TextEditingController();
final _balanceController = TextEditingController();

String _selectedPaymentMethod = '';
final _dateController = TextEditingController();
final TextEditingController _hourController = TextEditingController();
final TextEditingController _minuteController = TextEditingController();

void _selectHour(BuildContext context) async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime != null) {
    _hourController.text = pickedTime.hour.toString().padLeft(2, '0');
  }
}

void _selectMinute(BuildContext context) async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime != null) {
    _minuteController.text = pickedTime.minute.toString().padLeft(2, '0');
  }
}

void _selectDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {
    _dateController.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  void initState() {
    super.initState();
    // Fetch the patient list when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientProvider>(context, listen: false).getBranches();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PatientProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Register',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  height: 33.6 / 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'Name',
                        hintText: 'Enter your full name',
                        controller: _nameController,
                        onChanged: (value) {
                          // Handle name change
                        },
                      ),
                      CustomTextField(
                        label: 'Whatsapp Number',
                        hintText: 'Enter your Whatsapp Number',
                        controller: _numberController,
                        onChanged: (value) {
                          // Handle number change
                        },
                      ),
                      CustomTextField(
                        label: 'Address',
                        hintText: 'Enter your full Address',
                        controller: _addressController,
                        onChanged: (value) {
                          // Handle address change
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Location",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: ['Kozhikkode', 'Malappuram', 'Wayanad']
                            .map((location) => DropdownMenuItem(
                                  value: location,
                                  child: Text(location),
                                ))
                            .toList(),
                        onChanged: (value) {
                          provider.selectedBranch = value;
                        },
                        hint: const Text('Choose your location'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Branch",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Select branch',
                          border: OutlineInputBorder(),
                        ),
                        items: provider.branchList
                            .map((branch) => DropdownMenuItem<String>(
                                  value: branch.name ?? '',
                                  child: Text(branch.name ?? ''),
                                ))
                            .toList(),
                        onChanged: (value) {
                          provider.selectedBranch = value;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Treatment",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // Wrap the ListView.builder with Expanded to avoid overflow
                      ListView.builder(
                        shrinkWrap: true, // Helps prevent infinite height
                        itemCount: provider.savedTreatment.length,
                        itemBuilder: (context, index) {
                          final treatment = provider.savedTreatment[index];
                          return PackageCard(
                            treatmentCard: TreatmentCard(
                              id: treatment.id,
                              name: treatment.name,
                              onEdit: () {},
                              onDelete: () {
                                provider.removeTreatment(treatment.id);
                              },
                              maleCount: treatment.maleCount,
                              femaleCount: treatment.femaleCount,
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddTreatmentDialog();
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.78, horizontal: 8.52),
                            backgroundColor: Color.fromRGBO(
                                56, 154, 72, 0.3), // Primary button color
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.52)),
                            ),
                          ),
                          child: Text(
                            'Add Treatment',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      CustomTextField(
                        label: 'Total Amount',
                        hintText: 'Total Amount',
                        controller: _totalController,
                        onChanged: (value) {
                          // Handle address change
                        },
                      ),
                      CustomTextField(
                        label: 'Discount Amount',
                        hintText: 'Discount Amount',
                        controller: _discountController,
                        onChanged: (value) {
                          // Handle address change
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Payment Option",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Cash',
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedPaymentMethod = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Cash',
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                            // Card Radio Button
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Card',
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedPaymentMethod = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Card',
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                            // UPI Radio Button
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'UPI',
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedPaymentMethod = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'UPI',
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        label: 'Advance Amount',
                        hintText: 'Advance Amount',
                        controller: _advanceController,
                        onChanged: (value) {
                          // Handle address change
                        },
                      ),
                      CustomTextField(
                        label: 'Balance Amount',
                        hintText: 'Ba;ance Amount',
                        controller: _balanceController,
                        onChanged: (value) {
                          // Handle address change
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Payment Option",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      CustomTextField(
                        label: 'Treatment Date',
                        hintText: 'Select a date',
                        controller: _dateController,
                        onTapSuffixIcon: () {
                          _selectDate(context);
                        },
                        suffixIcon: const Icon(Icons.calendar_month),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Treatment Time",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Add spacing at the bottom
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'Hour',
                              hintText: 'HH',
                              controller: _hourController,
                              keyboardType: TextInputType.number,
                              onTapSuffixIcon: () {
                                _selectHour(context);
                              },
                              onChanged: (value) {
                                // Handle hour change if needed
                              },
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: CustomTextField(
                              label: 'Minute',
                              hintText: 'MM',
                              controller: _minuteController,
                              keyboardType: TextInputType.number,
                              onTapSuffixIcon: () {
                                _selectMinute(context);
                              },
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                              onChanged: (value) {
                                // Handle minute change if needed
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 62),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity, // Make the button take full width
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            // Handle Register button click
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => RegistrationPage()));
          },
          backgroundColor: const Color(0xFF006837),
          child: Text(
            "Save",
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
