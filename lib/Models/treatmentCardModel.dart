import 'package:flutter/material.dart';

class TreatmentCard {
  final String name;
  final int id;
  final int maleCount;
  final int femaleCount;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  // Constructor with required fields first
  TreatmentCard({
    required this.id,
    required this.name,
    required this.onEdit,
    required this.onDelete,
    this.maleCount = 0, // Default value set to 0
    this.femaleCount = 0, // Default value set to 0
  });
}
