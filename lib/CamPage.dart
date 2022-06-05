import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'GasPage.dart';

class CamPage extends StatefulWidget {
  const CamPage({Key? key}) : super(key: key);

  @override
  State<CamPage> createState() => _CamPageState();
}

class _CamPageState extends State<CamPage> {
  String led = '0';
  String sound = 'Not detected';
  String up = '0';
  String right = '0';
  String left = '0';
  String down = '0';
  String stop = '0';
  String faster = "0";
  String slower = "0";
  Color downbuttoncolor = Colors.white;
  Color rightbuttoncolor = Colors.white;
  Color leftbuttoncolor = Colors.white;
  Color upbuttoncolor = Colors.white;
  late Timer timer;
  var reference =
      FirebaseDatabase.instance.ref().child("sound").limitToFirst(1);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final myRef = FirebaseDatabase.instance.ref();
    myRef.child("sound").get().then((snapshot) {
      sound = snapshot.value.toString();
      setState(() {});
    });
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      myRef.child("sound").get().then((snapshot) {
        sound = snapshot.value.toString();
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          Padding(
            //gas
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 9),
            child: IconButton(
              icon: const Icon(Icons.local_gas_station),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GasPage()),
                );
              },
            ),
          )
        ],
        title: const Text(
          'Camera',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.red, Colors.white],
        )),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                width: 300,
                child: Text(
                  'Sound is $sound',
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              Container(
                height: 300,
                width: 300,
                color: Colors.black,
              ),
              Padding(padding: EdgeInsets.all(12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(right: 135)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Listener(
                        // up
                        onPointerDown: (details) async {
                          setState(() {
                            upbuttoncolor = Color.fromARGB(255, 244, 162, 156);
                          });
                          DatabaseReference myRef =
                              FirebaseDatabase.instance.ref();
                          final snapshot = await myRef.child("car/up").get();
                          var up = snapshot.value;
                          if (up == "0") {
                            up = "1";
                          } else {
                            up = "0";
                          }
                          await myRef.update({
                            "car": {
                              "faster": faster,
                              "slower": slower,
                              "stop": stop,
                              "up": up,
                              "left": left,
                              "right": right,
                              "down": down
                            }
                          });
                        },
                        onPointerUp: (details) async {
                          setState(() {
                            upbuttoncolor = Colors.white;
                          });
                        },
                        // highlightColor: Colors.red,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: upbuttoncolor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.arrow_upward_sharp,
                            color: Colors.red,
                          ),
                        )),
                  ),
                  Padding(padding: EdgeInsets.only(right: 70)),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        primary: Colors.red,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: () async {
                        DatabaseReference myRef =
                            FirebaseDatabase.instance.ref();
                        final snapshot = await myRef.child("car/faster").get();
                        var faster = snapshot.value;
                        print(faster);
                        if (faster == "0") {
                          faster = "1";
                        } else {
                          faster = "0";
                        }
                        myRef.update({
                          "car": {
                            "faster": faster,
                            "slower": slower,
                            "stop": stop,
                            "up": up,
                            "left": left,
                            "right": right,
                            "down": down
                          }
                        });
                      },
                      child: const Icon(Icons.arrow_drop_up_rounded),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: (MainAxisAlignment.center),
                children: [
                  Padding(padding: EdgeInsets.only(right: 80)),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Listener(
                        // left
                        onPointerDown: (details) async {
                          setState(() {
                            leftbuttoncolor =
                                Color.fromARGB(255, 244, 162, 156);
                          });
                          DatabaseReference myRef =
                              FirebaseDatabase.instance.ref();
                          final snapshot = await myRef.child("car/left").get();
                          var left = snapshot.value;
                          print(left);
                          if (left == "0") {
                            left = "1";
                          } else {
                            left = "0";
                          }
                          await myRef.update({
                            "car": {
                              "faster": faster,
                              "slower": slower,
                              "stop": stop,
                              "up": up,
                              "left": left,
                              "right": right,
                              "down": down
                            }
                          });
                        },
                        onPointerUp: (details) async {
                          setState(() {
                            leftbuttoncolor = Colors.white;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: leftbuttoncolor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.red,
                          ),
                        )),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Listener(
                        // right
                        onPointerDown: (details) async {
                          setState(() {
                            rightbuttoncolor =
                                Color.fromARGB(255, 244, 162, 156);
                          });
                          DatabaseReference myRef =
                              FirebaseDatabase.instance.ref();
                          final snapshot = await myRef.child("car/right").get();
                          var right = snapshot.value;
                          print(right);
                          if (right == "0") {
                            right = "1";
                          } else {
                            right = "0";
                          }
                          await myRef.update({
                            "car": {
                              "faster": faster,
                              "slower": slower,
                              "stop": stop,
                              "up": up,
                              "left": left,
                              "right": right,
                              "down": down
                            }
                          });
                        },
                        onPointerUp: (details) async {
                          setState(() {
                            rightbuttoncolor = Colors.white;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: rightbuttoncolor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.red,
                          ),
                        )),
                  ),
                  Padding(padding: EdgeInsets.only(right: 20)),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        primary: Colors.red,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: () async {
                        DatabaseReference myRef =
                            FirebaseDatabase.instance.ref();
                        final snapshot = await myRef.child("car/stop").get();
                        var stop = snapshot.value;
                        print(stop);
                        if (stop == "0") {
                          stop = "1";
                        } else {
                          stop = "0";
                        }
                        myRef.update({
                          "car": {
                            "faster": faster,
                            "slower": slower,
                            "stop": stop,
                            "up": up,
                            "left": left,
                            "right": right,
                            "down": down
                          }
                        });
                      },
                      child: const Icon(Icons.stop),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(right: 135)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Listener(
                        // down
                        onPointerDown: (details) async {
                          setState(() {
                            downbuttoncolor =
                                Color.fromARGB(255, 244, 162, 156);
                          });

                          DatabaseReference myRef =
                              FirebaseDatabase.instance.ref();
                          final snapshot = await myRef.child("car/down").get();
                          var down = snapshot.value;
                          downbuttoncolor = downbuttoncolor;
                          print(down);
                          if (down == "0") {
                            down = "1";
                          } else {
                            down = "0";
                          }
                          await myRef.update({
                            "car": {
                              "faster": faster,
                              "slower": slower,
                              "stop": stop,
                              "up": up,
                              "left": left,
                              "right": right,
                              "down": down
                            }
                          });
                        },
                        onPointerUp: (details) async {
                          setState(() {
                            downbuttoncolor = Colors.white;
                          });
                        },
                        // highlightColor: Colors.red,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: downbuttoncolor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.arrow_downward_outlined,
                            color: Colors.red,
                          ),
                        )),
                  ),
                  Padding(padding: EdgeInsets.only(right: 70)),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          primary: Colors.red,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15),
                        ),
                        onPressed: () async {
                          DatabaseReference myRef =
                              FirebaseDatabase.instance.ref();
                          final snapshot =
                              await myRef.child("car/slower").get();
                          var slower = snapshot.value;
                          print(slower);
                          if (slower == "0") {
                            slower = "1";
                          } else {
                            slower = "0";
                          }
                          myRef.update({
                            "car": {
                              "slower": slower,
                              "faster": faster,
                              "stop": stop,
                              "up": up,
                              "left": left,
                              "right": right,
                              "down": down
                            }
                          });
                        },
                        child: const Icon(Icons.arrow_drop_down_rounded)),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: () {},
                      child: Icon(downbuttoncolor == null
                          ? Icons.play_arrow
                          : Icons.pause))
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
