import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midterm_620710288/pig_weight.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PIG WEIGHT CALCULATOR',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var weghtCal = WeightCalcualte();

  final _controller = TextEditingController();
  final _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("PIG WEIGHT",
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.orange.shade400),
                      ),
                      Text("CALCULATOR",
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.deepOrange.shade400
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(image: AssetImage('assets/images/pig.png'), height: 160.0,),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("LENGTH"),
                                  Text("(cm)"),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _controller,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: 'Enter length',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                        ),
                      ),
                      Expanded(
                        child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("GIRTH"),
                                  Text("(cm)"),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _controller2,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: 'Enter length',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('CALCULATE',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        onPressed: (){
                          var length = double.tryParse(_controller.text);
                          var girth = double.tryParse(_controller2.text);
                          if(length == null || girth == null){
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('ERROR'),
                                  content: Text("Invalid input"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }else{
                            var weight = weghtCal.calculateWeight(length/100, girth/100);
                            var btmPigweight = weight-3;
                            var upperPigweight = weight+3;
                            var btmPrice = (btmPigweight*112.50).round();
                            var upperPrice = (upperPigweight*112.50).round();

                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('RESULT'),
                                  content: Text("Weight: $btmPigweight - $upperPigweight kg\nPrice: $btmPrice - $upperPrice Baht"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      )
      ,
    );
  }
}