import 'package:app_agenda/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final TextEditingController _txtTextoPadraoController =
      TextEditingController();

  void salvarTextoPadrao() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('texto_padrao', _txtTextoPadraoController.text);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Texto padrão salvo com sucesso!"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> deleteAllContatos() async {
    await DatabaseHelper.deleteAllContatos();
  }

  void confirmarAllDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Excluir Todos os Contatos"),
          content: const Text(
              "Tem certeza que deseja excluir todos os contatos? Esta ação não pode ser desfeita."),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size(110, 15),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: const Color(0xFF202d36),
                    elevation: 1,
                    shadowColor: Colors.white24,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size(110, 15),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: const Color(0xFF202d36),
                    elevation: 1,
                    shadowColor: Colors.white24,
                  ),
                  onPressed: () {
                    deleteAllContatos();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Excluir"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Configurações')),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Alterar Texto Padrão",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF202d36),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white10,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextField(
                    autofocus: false,
                    controller: _txtTextoPadraoController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 4,
                    cursorColor: Colors.white70,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF202d36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        salvarTextoPadrao();
                      },
                      child: Text(
                        "Salvar",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.green[400],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.white24,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF202d36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        confirmarAllDelete();
                      },
                      child: Text(
                        "Limpar Todos os Contatos",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.red[800],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "⚠ Cuidado! Este botão exclui todos os contatos de forma definitiva. Não há como desfazer essa ação.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
