import 'package:blogapp/revesion/game_button.dart';
import 'package:flutter/material.dart';

class CustomeLoginScreen extends StatefulWidget {
  const CustomeLoginScreen({super.key});

  @override
  State<CustomeLoginScreen> createState() => _CustomeLoginScreenState();
}

class _CustomeLoginScreenState extends State<CustomeLoginScreen> {
  late List<GameButton> gameList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gameList = doInit();
  }

  doInit() {
    var gameButton = [
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButton;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Tic Toc Toe",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          elevation: 0.0),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.orange, Colors.red])),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 9.0,
                  crossAxisSpacing: 6.0,
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: ContinuousRectangleBorder(),
                          padding: EdgeInsets.zero),
                      onPressed: () {},
                      child: Text(gameList[index].text)),
                );
              }),
        ),
      ),
    );
  }
}
