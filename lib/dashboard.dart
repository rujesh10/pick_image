import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:myqrcode/qrcode.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 225, 15, 0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QrcodeTest(),
              ));
        },
        child: Icon(Icons.qr_code_scanner_rounded),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floating action button position to center

      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: Colors.white,

        notchMargin:
            5, //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar

          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.currency_rupee_rounded,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.payments_rounded,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Color.fromARGB(255, 185, 41, 31),
                // width: 500,
                height: 150,
                child: Row(children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, right: 20),
                          child: Text(
                            "Good Morning!",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 20),
                          child: Text(
                            "Ankit Shrestha!",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 120,
                    ),
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          CircleAvatar(
                            child: Text(
                              "AS",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 155, 19, 10)),
                            ),
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120, left: 11, right: 11),
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey, width: 0.5),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 130,
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Icon(Icons.wallet),
                            SizedBox(
                              width: 10,
                            ),
                            Text("SPECIAL SAVING")
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text("0100023969269"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Row(
                            children: [
                              Text(
                                "NPR",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Text(
                                  "23,277",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: Column(
                      children: [],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
