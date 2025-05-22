import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 75,
              width: 75,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset('assets/logo.png'),
              ),
            ),
            const Text("ContactHub"),
            const SizedBox(
              width: 45,
            ),
          ],
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
          bottom: 280,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sua agenda livre de contatos passageiros!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                "O ContactHub foi criado para facilitar a sua vida: um lugar exclusivo para armazenar contatos importantes sem ocupar espaço na agenda do seu telefone. Com apenas um toque, você inicia conversas no WhatsApp, sem complicações e sem precisar salvar o número na memória do celular. Ideal para quem lida com muitos contatos temporários, clientes ou novos amigos. Mantenha sua lista sempre organizada, acessível e protegida dentro do app.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                "ContactHub: simplifique sua rotina e tenha seus contatos sempre à mão!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
