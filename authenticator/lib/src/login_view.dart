import 'package:authenticator/src/user_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.onTap}) : super(key: key);
  final Function(String id) onTap;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserAuth auth = UserAuth();

  onLogin() async {
    final id = await auth.login(emailController.text, passwordController.text);
    if (id != null) return widget.onTap(id);
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Login incorreto!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                width: 480,
                // Não é uma pratica muito boa, mas deixa ai por enquanto
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "login.png",
                          fit: BoxFit.fill,
                        ),
                      ],
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
                      font_size: 14,
                      text: "Login",
                      onTap: onLogin,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Não tem conta?   "),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Cadastrar!",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class NewText extends StatelessWidget {
  final text;
  final color;
  final size;
  final bold;

  const NewText({Key? key, this.text, this.color, this.size, this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: bold),
    );
  }
}

class NewButton extends StatelessWidget {
  final text;
  final font_size;
  final onTap;

  const NewButton({Key? key, this.text, this.font_size, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 120,
      child: ElevatedButton(
        child: Text(text.toUpperCase(), style: TextStyle(fontSize: font_size)),
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
  final obscure;
  final label;
  final hint;
  final controller;

  const NewTextField(
      {Key? key, this.obscure, this.label, this.hint, this.controller})
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
