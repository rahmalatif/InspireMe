import 'package:flutter/material.dart';

class FeelingView extends StatelessWidget {
  const FeelingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            child: Image.asset("assets/JPG/feeling.png", fit: BoxFit.fill,),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.4,
          ),

          Center(
            child: Text("How are you feeling Lately?", style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                buildMoodItem("😃", "Awesome"),
                buildMoodItem("🙂", "Good"),
                buildMoodItem("😔", "Sad"),
                buildMoodItem("😐", "Ok"),
                buildMoodItem("😡", "Angry"),
                buildMoodItem("🤔", "Other"),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/improve');
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
                  "Got It!",
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

Widget buildMoodItem(String emoji, String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black, width: 1),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 32),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),

  );
}