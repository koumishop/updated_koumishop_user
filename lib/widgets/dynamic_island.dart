import 'package:flutter/material.dart';

class DynamicIsland extends StatefulWidget {
  const DynamicIsland({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DynamicIsland();
  }
}

class _DynamicIsland extends State<DynamicIsland> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 35,
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 35,
                width: 35,
                child: CircularProgressIndicator(),
              ),
              Text(
                "Traitement en cours...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
