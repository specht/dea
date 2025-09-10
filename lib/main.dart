import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEA',
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(elevation: 2),
        colorSchemeSeed: Colors.green,
      ),
      home: MyHomePage(title: 'Deterministischer Endlicher Automat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> inputButtons = [];
  String input = '';
  DEA automat = DEA();

  _MyHomePageState() {
    for (var s in automat.validInputs) {
      inputButtons.add(
        Padding(
          padding: EdgeInsets.all(5),
          child: ElevatedButton(
            style: OutlinedButton.styleFrom(padding: EdgeInsets.all(15)),
            onPressed: () => handleInput(s),
            child: Text(s, style: TextStyle(fontSize: 20)),
          ),
        ),
      );
    }
    inputButtons.add(
      Padding(
        padding: EdgeInsets.all(5),
        child: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => {
            setState(() {
              input = '';
              automat = DEA();
            }),
          },
        ),
      ),
    );
  }

  void handleInput(String s) {
    setState(() {
      input += s;
      automat.handleInput(s);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, color: Colors.green[300], size: 100.0),
            Padding(padding: EdgeInsets.all(10)),
            Text(automat.description, style: TextStyle(fontSize: 20)),
            Padding(padding: EdgeInsets.all(10)),
            Wrap(children: inputButtons),
            Padding(padding: EdgeInsets.all(10)),
            Text("Eingabe: $input", style: TextStyle(fontSize: 20)),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "Aktueller Zustand: ${automat.state}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Eingabe akzeptiert: ", style: TextStyle(fontSize: 20)),
                Text(
                  automat.isAccepting() ? 'ja' : 'nein',
                  style: TextStyle(
                    fontSize: 20,
                    color: automat.isAccepting() ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Hier implementieren Sie Ihren Deterministischen
// Endlichen Automaten (DEA).
class DEA {
  // Der Zustand wird als String gespeichert.
  // Definieren Sie hier Ihren Anfangszustand.
  String state = 'q0';

  // Definieren Sie hier die Menge der
  // möglichen Eingaben
  List validInputs = ['d'];

  // Beschreiben Sie hier, welche Eingaben Ihr Automat akzeptiert
  String description = 'Dieser Automat prüft, ob das Licht eingeschaltet ist.';

  // Implementieren Sie hier Ihre Übergangsfunktion δ
  // Je nach aktuellem Zustand `state` und Eingabe
  // `input` soll ein neuer Zustand gesetzt werden.
  void handleInput(String input) {
    if (input == 'd') {
      if (state == 'q0') {
        state = 'q1';
      } else if (state == 'q1') {
        state = 'q0';
      }
    }
  }

  // Definieren Sie hier, welche Zustände akzeptierend sind
  bool isAccepting() {
    return ['q1'].contains(state);
  }
}
