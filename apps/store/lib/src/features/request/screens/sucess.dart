import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color colorTextDark = Color(0xff245B4C);
const Color colorAccent = Color(0xFF5BE3BF);

class SucessScreen extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SucessScreen({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAccent,
      bottomNavigationBar: BottomNavButton('Concluído', onPressed),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.nunito(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: colorTextDark),
          ),
          const SizedBox(height: 18),
          const Center(
            child: Icon(Icons.check_circle_outline,
                color: colorTextDark, size: 62),
          ),
        ],
      ),
    );
  }
}
