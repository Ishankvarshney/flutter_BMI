import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Your BMI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var inchController = TextEditingController();
  var ftController = TextEditingController();

  var toggleWidth = false;
  var _width = 270;
  var result = '';
  var bgColor = Colors.purple[50];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.slowMiddle,
          color: bgColor,
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        const Text(
                          'Calculate BMI',
                          style: TextStyle(
                              fontSize: 30, fontFamily: 'Times New Roman'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              toggleWidth = !toggleWidth;
                              print('click');
                              if (toggleWidth) {
                                _width = 270;
                              } else {
                                _width = 400;
                              }
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4), // Customize padding here
                              minimumSize: Size
                                  .zero, // Ensures the padding is strictly controlled
                              tapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap, // Reduces touch target size
                            ),
                            child: const Text(
                              'Change Width',
                              style: TextStyle(fontSize: 7),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              bgColor = Colors.purple[50];
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4), // Customize padding here
                              minimumSize: Size
                                  .zero, // Ensures the padding is strictly controlled
                              tapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap, // Reduces touch target size
                            ),
                            child: const Text(
                              'Reset Color',
                              style: TextStyle(fontSize: 7),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    width: _width.toDouble(),
                    child: Column(
                      children: [
                        TextField(
                          controller: wtController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text('Enter your weight in KG'),
                              prefixIcon: Icon(Icons.line_weight_rounded)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: ftController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text('Enter your height in Feet'),
                              prefixIcon: Icon(Icons.height)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: inchController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text('Enter your Height in inches'),
                              prefixIcon: Icon(Icons.height_rounded)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var wt = wtController.text.toString();
                        var inch = inchController.text.toString();
                        var ft = ftController.text.toString();

                        if (wt != '' && inch != '' && ft != '') {
                          var iWt = int.parse(wt);
                          var iFt = int.parse(ft);
                          var iInch = int.parse(inch);
                          print(iWt);
                          print(iFt);
                          print(iInch);
                          var tInch = (iFt * 12) + iInch;
                          var tCm = (tInch * 2.54);
                          var tM = tCm / 100;
                          var bmi = iWt / (tM * tM);
                          var msg = '';

                          if (bmi > 25) {
                            msg = 'Your Overweight';
                            bgColor = Colors.orange;
                          } else if (bmi < 18) {
                            msg = 'Your underweight';
                            bgColor = Colors.red;
                          } else {
                            msg = 'Your healthy';
                            bgColor = Colors.green;
                          }

                          setState(() {
                            result =
                                ' $msg \n Your BMI is ${bmi.toStringAsFixed(2)}';
                          });
                        } else {
                          setState(() {
                            result = 'Please fill all the required blanks!';
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .deepPurple, // Set the button background color
                      ),
                      child: Text(
                        'calculate',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    result,
                    style: TextStyle(
                        fontFamily: 'Times Noe Roman',
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
