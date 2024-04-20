import 'package:flutter/material.dart';

//* A arte ninja de usar callbacks
//* Callbacks, funções executadas automaticamente depois de outra função
//* Callbacks geralmente são de dois tipos:
//* Void callbacks: sem passagem de parâmetros
//* Function callbacks: com passagem de parâmetros
//* Exemplo:
//* E quando você mudar o radius, padding ou incluir um doubleTap?
//* Você deve mudar todos widgets daquele tipo.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const TrafficLightPage(title: 'Flutter Traffic Light'),
    );
  }
}

class TrafficLightPage extends StatefulWidget {
  const TrafficLightPage({super.key, required this.title});

  final String title;

  @override
  State<TrafficLightPage> createState() => _TrafficLightPageState();
}

class _TrafficLightPageState extends State<TrafficLightPage> {
  MaterialColor selectedLight = Colors.red;
  String message = 'Stop!';
  List<MaterialColor> lightColors = [Colors.red, Colors.yellow, Colors.green];

  onSelectLightParent(MaterialColor light, String newMessage) {
    setState(() {
      selectedLight = light;
      message = newMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...lightColors.map(
              (lightColor) => LightCircleWidget(
                light: lightColor,
                selectedLight: selectedLight,
                onSelectLight: (color, message) {
                  onSelectLightParent(color, message);
                },
              ),
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class LightCircleWidget extends StatelessWidget {
  const LightCircleWidget({
    super.key,
    required this.light,
    required this.selectedLight,
    required this.onSelectLight,
  });

  final MaterialColor light;
  final MaterialColor selectedLight;
  // final VoidCallback onSelectLight;
  final Function(MaterialColor, String) onSelectLight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: CircleAvatar(
          radius: 20,
          backgroundColor:
              selectedLight == light ? light : Colors.grey.shade200,
        ),
        onTap: () {
          late String message;
          switch (light) {
            case Colors.red:
              message = 'Stop!!!';
              break;
            case Colors.yellow:
              message = 'Caution...';
              break;
            case Colors.green:
              message = 'Go and be careful.';
              break;
            default:
          }
          onSelectLight(light, message);
        },
      ),
    );
  }
}
