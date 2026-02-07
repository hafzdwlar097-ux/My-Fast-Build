import 'package:flutter/material.dart';
// random comment to change file hash: this is a random comment

void main() {
  // This is the main function where the app starts
  // random comment to change file hash: random comment 2
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // random comment to change file hash: comment 3
    return MaterialApp(
      title: 'أسباب الخضا',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // This is a stateless widget for the home page
  // random comment to change file hash: this is a comment
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ما أسباب الخضا'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // random comment to change file hash: this is another comment
            Text(
              'هناك العديد من الأسباب التي تؤدي إلى الخضا، من بينها:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // random comment to change file hash: this is comment 5
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      '1. الضغوطات النفسية',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('الضغوطات النفسية مثل الخوف، القلق، والتوتر يمكن أن تؤدي إلى الخضا.'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            // random comment to change file hash: this is a comment
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      '2. مشاكل الصحة',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('مشاكل الصحة مثل الألم المزمن، أو الإصابة بمرض خطير يمكن أن تؤدي إلى الخضا.'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            // random comment to change file hash: this is comment 7
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      '3. مشاكل العلاقات',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('مشاكل العلاقات مثل المشاكل الزوجية، أو مشاكل الأصدقاء يمكن أن تؤدي إلى الخضا.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
