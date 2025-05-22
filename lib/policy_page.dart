import 'package:flutter/material.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Política de Privacidade')),
      body: const Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 30,
          bottom: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ContactHub: sua privacidade em foco.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Divider(
              color: Colors.white24,
              thickness: 1,
            ),
            Text(
              "Coletamos apenas as informações necessárias para que você possa armazenar e gerenciar seus contatos com segurança e praticidade.\n\n✅ Dados armazenados: números de telefone adicionados por você, dentro do próprio app.\n\n✅ Não acessamos: sua agenda de contatos, fotos, arquivos ou quaisquer outros dados pessoais do seu dispositivo.\n\n✅ Sem compartilhamento: não compartilhamos, vendemos ou transferimos suas informações a terceiros.\n\n✅ Segurança: usamos medidas adequadas para proteger os dados salvos no app contra acessos não autorizados.\n\nAo utilizar o ContactHub, você concorda com esta política e com o uso das funcionalidades oferecidas.\n\nEm caso de dúvidas ou sugestões, entre em contato conosco.",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                height: 1.3,
              ),
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: Colors.white24,
              thickness: 1,
            ),
            Text(
              "Última atualização: 22/05/2025",
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
    );
  }
}
