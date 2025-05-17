import 'package:flutter/material.dart';

class LoadingAppWidget extends StatelessWidget {
  const LoadingAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80,
        width: 80,
        
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0E3C53)),
          strokeWidth: 20,
          
        ),
      ),
    );
  }
}