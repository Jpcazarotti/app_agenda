import 'package:app_agenda/database_helper.dart';
import 'package:app_agenda/drawer_menu.dart';
import 'package:flutter/material.dart';

/* open_share_plus */
/* mask_text_input_formatter */

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _contatos = [];
  final TextEditingController _txtNomeController = TextEditingController();
  final TextEditingController _txtTelefoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarContatos();
  }

  Future<void> carregarContatos() async {
    final contatos = await DatabaseHelper.getContatos();
    setState(() {
      _contatos = contatos;
    });
  }

  void criarContato() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Adicionar Contato"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _txtNomeController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                ),
              ),
              TextField(
                controller: _txtTelefoneController,
                decoration: const InputDecoration(
                  labelText: "Celular",
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () async {
                    if (_txtNomeController.text.isNotEmpty &
                        _txtTelefoneController.text.isNotEmpty) {
                      await DatabaseHelper.createContatos(
                        _txtNomeController.text,
                        _txtTelefoneController.text,
                      );
                      _txtNomeController.clear();
                      _txtTelefoneController.clear();
                      carregarContatos();
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: const Text("Adicionar"),
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
        appBar: AppBar(
          title: const Text("Schedule"),
          centerTitle: true,
        ),
        drawer: const DrawerMenu(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF24333D),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white10,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _txtNomeController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.white30,
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.search_rounded,
                      color: Colors.white30,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _contatos.length,
                itemBuilder: (context, index) {
                  final contato = _contatos[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.messenger_rounded,
                      color: Colors.white70,
                    ),
                    title: Text(
                      contato['nome'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      contato['telefone'],
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: Colors.blueGrey,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            boxShadow: [
              BoxShadow(
                color: Colors.white10,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: () {
              criarContato();
            },
            backgroundColor: const Color(0xff20c065),
            foregroundColor: const Color(0xFF24333D),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.person_add_rounded,
              size: 35,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
