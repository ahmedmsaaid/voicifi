import 'package:flutter/material.dart';

class Upload extends StatelessWidget {
  const Upload({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black, // أسود رمادي
            Color(0xFF6a1b9a), // لون أرجواني داكن
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),

      ),
      child:

      Center(
        child:  Text('Home'),

      ),

    );
  }
}
