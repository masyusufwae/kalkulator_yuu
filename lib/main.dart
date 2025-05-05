import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/riwayat': (context) => RiwayatPage(history: ModalRoute.of(context)!.settings.arguments as List<String>),
        '/profil': (context) => ProfilPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String input = '';
  List<String> history = [];
  int _selectedIndex = 0;

  void appendInput(String value) {
    setState(() {
      input += value;
    });
  }

  void clearInput() {
    setState(() {
      input = '';
    });
  }

  void deleteLastInput() {
    setState(() {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    });
  }

  void calculateResult() {
    try {
      final result = _evaluateExpression(input);
      setState(() {
        history.add('$input = $result');
        input = result.toString();
      });
    } catch (e) {
      setState(() {
        input = 'Error';
      });
    }
  }

  double _evaluateExpression(String expression) {
    try {
      expression = expression.replaceAll('×', '*').replaceAll('÷', '/');
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      throw Exception("Invalid operation");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, '/');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/riwayat', arguments: history);
    } else if (index == 2) {
      Navigator.pushNamed(context, '/profil');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kalkulator')),
      body: Center(
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 400, // Membatasi lebar kalkulator
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 380, // Menetapkan lebar tetap pada kotak input
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: BoxConstraints(minHeight: 50, maxHeight: 80),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        input,
                        style: TextStyle(fontSize: 32, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildButtonRow(['AC', 'DEL', '+/-', '÷']),
                _buildButtonRow(['7', '8', '9', '×']),
                _buildButtonRow(['4', '5', '6', '-']),
                _buildButtonRow(['1', '2', '3', '+']),
                _buildButtonRow(['%', '0', ',', '=']),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Kalkulator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildButtonRow(List<String> labels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: labels.map((label) => _buildButton(label)).toList(),
    );
  }

  Widget _buildButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _getButtonColor(label), // Warna latar belakang tombol
            foregroundColor: Colors.white, // Warna teks tombol
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Membuat tombol menjadi kotak
            textStyle: TextStyle(fontSize: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Membuat tombol sedikit tumpul
            ),
          ),
          onPressed: () {
            if (label == 'AC') {
              clearInput();
            } else if (label == 'DEL') {
              deleteLastInput();
            } else if (label == '=') {
              calculateResult();
            } else {
              appendInput(label);
            }
          },
          child: Text(label),
        ),
      ),
    );
  }

  Color _getButtonColor(String label) {
    if (label == 'AC' || label == 'DEL' || label == '+/-' || label == '÷' || label == '×' || label == '-' || label == '+' || label == '=') {
      return Colors.blue;
    } else {
      return Colors.black54;
    }
  }
}

class RiwayatPage extends StatelessWidget {
  final List<String> history;

  RiwayatPage({required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat')),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(history[index], style: TextStyle(fontSize: 18)),
          );
        },
      ),
    );
  }
}

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/profile_image.png'),
              radius: 50, // Sesuaikan ukuran lingkaran
            ),
            SizedBox(height: 20),
            Text('Profil Pengguna', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text('Muhammad Yusuf', style: TextStyle(fontSize: 20)),
            SizedBox(height:10), 
            Text('XI RPL 2', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('25', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}