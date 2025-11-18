import 'package:flutter/material.dart';
import 'package:inspireme/core/Design/app_Image.dart';

class NameView extends StatelessWidget {
  const NameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
              child: Image.asset(
            "assets/JPG/name.png",
            fit: BoxFit.cover,
          )),
          Positioned(
             top: 200,
              height: 200,
              right: 0,
              left: 0,
              child: Center(
                child: Text(
                  "Enter your name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              )),
          Positioned(
              top: 330,
              left: 40,
              right: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Name",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              )),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/feeling');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 140,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
