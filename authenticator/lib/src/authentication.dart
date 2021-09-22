import 'package:authenticator/src/user_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  AuthenticationPage({Key? key, required this.onTap}) : super(key: key);
  final Widget Function(String id) onTap;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final UserAuth auth = UserAuth();

  onLogin(context) async {
    final id = await auth.login(emailController.text, passwordController.text);
    if (id == null)
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login incorreto!')));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: auth.uidState,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      onTap: () => onLogin(context),
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
              )),
            );
          }
          return onTap(snapshot.data!);
        });
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
  final String text;
  final double fontSize;
  final VoidCallback onTap;

  const NewButton({Key? key, required this.text, required this.fontSize, required this.onTap})
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
