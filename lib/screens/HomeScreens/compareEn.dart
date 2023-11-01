import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unused_import

class CompareEn extends StatefulWidget {
  const CompareEn({super.key});

  @override
  State<CompareEn> createState() => _CompareEnState();
}

class _CompareEnState extends State<CompareEn> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Mulish',
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              MaterialButton(
                onPressed: () {},
                minWidth: 0,
                height: 100,
                child: Image.asset(
                  'assets/images/icons/close.png',
                  width: 20,
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0, 60, 0),
                  child: Text(
                    'Compare Environment ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(225, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Your Environment for Tomates is',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(230, 49, 108, 236),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 18, right: 18, top: 5, bottom: 5),
                        child: Text(
                          'Good',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 15),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(199, 255, 255, 255),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Image.asset(
                              'assets/images/icons/temp.png',
                              width: 14,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Temperature',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 120),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 64, 212, 0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 18, right: 18, top: 6, bottom: 6),
                                child: Text(
                                  'Great',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, bottom: 10, right: 0),
                      child: Row(
                        children: [
                          const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 30, bottom: 10),
                                child: Text(
                                  'Best',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                '16-24 °C',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 120),
                            child: Image.asset(
                              'assets/images/icons/line.jpg',
                              width: 4,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 15, bottom: 10),
                                  child: Text(
                                    'Yours',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  '18 °C',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 15),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(199, 255, 255, 255),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Image.asset(
                              'assets/images/icons/Light1.png',
                              width: 25,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Light',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 176),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(230, 49, 108, 236),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 18, right: 18, top: 6, bottom: 6),
                                child: Text(
                                  'Good',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, bottom: 20, right: 0),
                      child: Row(
                        children: [
                          const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 50, bottom: 10),
                                child: Text(
                                  'Best',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                '4,2k-9k lux',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 120),
                            child: Image.asset(
                              'assets/images/icons/line.jpg',
                              width: 4,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 5, bottom: 10),
                                  child: Text(
                                    'Yours',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  '4k lux',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 15),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(199, 255, 255, 255),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Image.asset(
                              'assets/images/icons/Humidity1.png',
                              width: 17,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Humidity',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 145),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 103, 36),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 25, right: 25, top: 6, bottom: 6),
                                child: Text(
                                  'Bad',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, bottom: 20, right: 0),
                      child: Row(
                        children: [
                          const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 30, bottom: 10),
                                child: Text(
                                  'Best',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                '70-78 %',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 120),
                            child: Image.asset(
                              'assets/images/icons/line.jpg',
                              width: 4,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 5, bottom: 10),
                                  child: Text(
                                    'Yours',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  '64 %',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
