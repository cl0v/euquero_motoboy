import 'package:authenticator/src/user_auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


//TODO: Adicionar tela de carregamento
class AuthenticationPage extends StatelessWidget {
  AuthenticationPage({Key? key, required this.onLogin, required this.onCreate}) : super(key: key);
  final Future<Widget> Function(String id) onLogin;
  final Future<Widget> Function() onCreate;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final UserAuth auth = UserAuth();

  _onLogin(context) async {
    try {
      await auth.login(emailController.text, passwordController.text);
    } catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Usuario ou senha inválido!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: auth.uidState,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
              body: ListView(
                children: [
                  Image.asset(
                    "assets/login.png",
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  NewTextField(
                    controller: emailController,
                    obscure: false,
                    hint: "Digite seu email",
                    label: "Email",
                  ),
                  NewTextField(
                    controller: passwordController,
                    obscure: true,
                    hint: "Digite sua senha",
                    label: "Senha",
                  ),
                  Divider(
                    height: 50,
                  ),
                  NewButton(
                    fontSize: 14,
                    text: "Login",
                    onTap: () => _onLogin(context),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Não tem conta?   "),
                      TextButton(
                        onPressed: () async => push(context, await onCreate.call()),
                        //() => launch(
                          //  "https://wa.me/553584633939?text=Cadartrar-me"),
                        child: Text(
                          "Cadastrar!",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return FutureBuilder<Widget>(
              future: onLogin(snapshot.data!),
              builder: (c, snap) {
                if (snap.data != null)
                  return snap.data!;
                else
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
              });
        });
  }
}

class NewButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final VoidCallback onTap;

  const NewButton(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 120,
      child: ElevatedButton(
        child: Text(text.toUpperCase(), style: TextStyle(fontSize: fontSize)),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.orangeAccent)))),
        onPressed: onTap,
      ),
    );
  }
}

class NewTextField extends StatelessWidget {
  final bool obscure;
  final String? label;
  final String? hint;
  final TextEditingController? controller;

  const NewTextField(
      {Key? key, required this.obscure, this.label, this.hint, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: hint,
        ),
      ),
    );
  }
}
