import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

final login = TextEditingController();
final password = TextEditingController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const LoginScreen(),
    );
  }
}

class Usuario {
  String name;
  String login;
  String password;

  Usuario(this.name, this.login, this.password);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String tlogin = '';
  String tpassword = '';
  int tconteo = 0;

  List<Usuario> _usuario = [
    Usuario("Noemi Galicia", "Noemi", "1234"),
    Usuario("Gabriela Noemi Hernández", "Gabriela", "0123"),
    Usuario("Juan Pablo", "Pablo", "4567"),
  ];

  void _login() {
    tlogin = login.text;
    tpassword = password.text;
    bool usuarioEncontrado = false;
    Usuario? usuarioLogeado;

    if (tlogin.isNotEmpty && tpassword.isNotEmpty) {
      for (var usuario in _usuario) {
        if (tlogin == usuario.login && tpassword == usuario.password) {
          usuarioEncontrado = true;
          usuarioLogeado = usuario;
          break;
        }
      }

      if (usuarioEncontrado) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => PaginaBienvenida(usuario: usuarioLogeado!),
          ),
        );
      } else {
        setState(() {
          tconteo++;  // Incrementar el conteo si las credenciales no coinciden
        });
      }
    } else {
      setState(() {
        tconteo++;  // También incrementar el conteo si alguno está vacío
      });
    }

    login.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda Parcial 5°A'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "INICIAR SESIÓN",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: login,
              decoration: const InputDecoration(
                hintText: "login",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                hintText: "password",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text("Entrar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 108, 90, 200), // Color de fondo del botón
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Intentos fallidos: $tconteo",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// Página de bienvenida después de iniciar sesión
class PaginaBienvenida extends StatelessWidget {
  final Usuario usuario;

  const PaginaBienvenida({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenido'), backgroundColor: Colors.teal),
      
      body: Center(
        child: Text(
          'Bienvenido, ${usuario.name}!',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}