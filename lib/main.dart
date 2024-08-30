import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List randomColorList = [];

  List randomColor() {
    var random = Random();
    int a = random.nextInt(255);
    int r = random.nextInt(255);
    int g = random.nextInt(255);
    int b = random.nextInt(255);
    return [Color.fromARGB(a, r, g, b), a, r, g, b];
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      randomColorList.add(randomColor());
    }
  }

  void updateColorList() {
    setState(() {
      for (int i = 0; i < randomColorList.length; i++) {
        int x = 12;
        int y = Random().nextInt(3);
        randomColorList[i][y+2] = (randomColorList[i][y+2] + x) % 255;
        randomColorList[i][0] = Color.fromARGB(randomColorList[i][1], randomColorList[i][2], randomColorList[i][3], randomColorList[i][4]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Yolo'),
        ),
        body: ListView.builder(
          itemBuilder: (_, index) {
            if (randomColorList.length <= index) {
              randomColorList.add(randomColor());
            }
            var colorData = randomColorList[index];
            return Container(
              color: colorData[0],
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Item $index'),
                    Text('a: ${colorData[1]}'),
                    Text('r: ${colorData[2]}'),
                    Text('g: ${colorData[3]}'),
                    Text('b: ${colorData[4]}'),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            updateColorList();
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.business), label: 'Business'),
          ],
        ),
        drawer: const Drawer(
          backgroundColor: Colors.amber,
          child: Text('Yo!'),
        ),
      ),
    );
  }
}
