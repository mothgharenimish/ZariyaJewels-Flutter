
import 'package:flutter/material.dart';

class Categorycard extends StatelessWidget {
final String category;
final bool isSelected;
const Categorycard({super.key, required this.category, required this.isSelected});


  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF228B22) : Colors.grey.shade200,
        border: Border.all(
          color: isSelected ? Colors.black.withValues(alpha: 0.00) : Colors.black.withValues(alpha: 0.20),
          width: 2,

        ),
        borderRadius: BorderRadius.circular(12),


      ),
      child: Center(child: Text(category,style: TextStyle(fontSize: 14,color: isSelected ? Colors.white : Colors.black,fontWeight: FontWeight.bold),)),
    );
  }
}
