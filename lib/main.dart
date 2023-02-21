import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:convert';

void main() {
  document.documentElement?.style.display = 'none';
  runApp(const MyApp());

  window.onMessage.listen((MessageEvent event) {
    var item = event.data;
    if (item['HideHud']) {
      // make whole page invisible like display: none in CSS
      document.documentElement?.style.display = 'none';
      postMessage(json.encode({'message': 'none'}));
    } else if (!item['HideHud']) {
      document.documentElement?.style.display = 'block';

      postMessage(json.encode({'message': 'block'}));
    }
  });
}

void postMessage(String message) {
  HttpRequest.postFormData('http://web_test/enableInput', {'message': message})
      .then((HttpRequest request) {
    // handle the response if needed
  }).catchError((error) {
    // handle the error if needed
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
