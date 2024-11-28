import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shihas_noviindus/Models/TreatmentModel.dart';
import 'package:shihas_noviindus/Models/branchModel.dart';
import 'package:shihas_noviindus/Models/treatmentCardModel.dart';
import 'package:shihas_noviindus/utils/constants.dart';

import '../Models/patientModel.dart';

class PatientProvider with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  List<Patient> _patientList = [];
  List<Branches> _branchList = [];
  List<Treatment?> treatmentList = [];
  List<TreatmentCard> _savedTreatment = [];

  // String? _selectedLocation;
  String? _selectedBranch;
  String? selectedTreatment;
  int? selectedTreatmentId;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<Patient> get patientList => _patientList;
  List<Branches> get branchList => _branchList;
  // List<Treatment> get treatmentList => _treatmentList;
  List<TreatmentCard> get savedTreatment => _savedTreatment;

  // String? get selectedLocation => _selectedLocation;

  // set selectedLocation(String? location) {
  //   _selectedLocation = location;
  //   notifyListeners();
  // }

  set selectedBranch(String? branch) {
    _selectedBranch = branch;
    notifyListeners();
  }

  // set selectedTreatment(String? treat) {
  //   _selectedTreatment = treat;
  //   notifyListeners();
  // }
  Future<void> saveTreatment(TreatmentCard treatment) async {
    _savedTreatment.add(treatment);
    notifyListeners();
  }

  void removeTreatment(int treatmentId) {
    savedTreatment.removeWhere((treatment) => treatment.id == treatmentId);
    notifyListeners(); // Notify listeners to update the UI
  }

  Future<void> getPatientList() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    const url = "${Constants.baseUrl}PatientList";

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        _errorMessage = 'User not authenticated';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true) {
          // Assuming 'data' contains the patient list
          PatientModel patientModel = PatientModel.fromJson(data);
          _patientList = patientModel.patient ?? [];
        } else {
          _errorMessage = data['message'] ?? 'Failed to fetch patients';
        }
      } else {
        _errorMessage =
            'Failed to fetch patients. Status code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getBranches() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    const url = "${Constants.baseUrl}BranchList";

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        _errorMessage = 'User not authenticated';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true) {
          // Assuming 'data' contains the patient list
          BranchModel branchModel = BranchModel.fromJson(data);
          _branchList = branchModel.branches ?? [];
        } else {
          _errorMessage = data['message'] ?? 'Failed to fetch patients';
        }
      } else {
        _errorMessage =
            'Failed to fetch patients. Status code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTreatments() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    const url = "${Constants.baseUrl}TreatmentList";

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        _errorMessage = 'User not authenticated';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true) {
          // Assuming 'data' contains the treatment list
          TreatmentModel treatmentModel = TreatmentModel.fromJson(data);
          treatmentList = treatmentModel.treatments ?? [];
        } else {
          _errorMessage = data['message'] ?? 'Failed to fetch treatments';
        }
      } else {
        _errorMessage =
            'Failed to fetch treatments. Status code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
