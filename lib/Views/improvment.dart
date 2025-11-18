import 'package:flutter/material.dart';

class ImprovmentView extends StatelessWidget {
  const ImprovmentView({super.key});

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
                buildImprovedItems("Faith & Spirituality"),
                buildImprovedItems("Happiness"),
                buildImprovedItems("Stress & Anxiety"),
                buildImprovedItems("Achieving goals"),
                buildImprovedItems("Self-esteem"),
                buildImprovedItems("Health"),
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
                  Navigator.pushNamed(context, '/main');
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

Widget buildImprovedItems( String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black, width: 1),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,

            ),
          ),
        ),
      ],
    ),

  );
}