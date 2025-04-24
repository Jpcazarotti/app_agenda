import 'package:app_agenda/database_helper.dart';
import 'package:app_agenda/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/* open_share_plus */
/* mask_text_input_formatter !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _contatos = [];
  final TextEditingController _txtNomeController = TextEditingController();
  final TextEditingController _txtTelefoneController = TextEditingController();
  final TextEditingController _txtCidadeController = TextEditingController();
  final TextEditingController _txtEditarNomeController =
      TextEditingController();
  final TextEditingController _txtEditarTelefoneController =
      TextEditingController();
  final TextEditingController _txtEditarCidadeController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final mask = MaskTextInputFormatter(
    mask: '+55 (0##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

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
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _txtNomeController,
                  decoration: const InputDecoration(
                    labelText: "Nome *",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo Nome é obrigatório!";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    controller: _txtTelefoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [mask],
                    decoration: const InputDecoration(
                      labelText: "Celular *",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 19) {
                        return "O campo Celular é obrigatório e deve estar completo!";
                      }
                      return null;
                    },
                  ),
                ),
                TextFormField(
                  controller: _txtCidadeController,
                  decoration: const InputDecoration(
                    labelText: "Cidade",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _txtNomeController.clear();
                    _txtTelefoneController.clear();
                    _txtCidadeController.clear();
                  },
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &
                        _txtNomeController.text.isNotEmpty &
                        _txtTelefoneController.text.isNotEmpty) {
                      await DatabaseHelper.createContatos(
                        _txtNomeController.text,
                        mask.getMaskedText(),
                        _txtCidadeController.text,
                      );
                      _txtNomeController.clear();
                      _txtTelefoneController.clear();
                      _txtCidadeController.clear();
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

  void editContato(int index) {
    final dadosContato = _contatos[index];

    _txtEditarNomeController.text = dadosContato['nome'];
    _txtEditarTelefoneController.text = dadosContato['telefone'];
    _txtEditarCidadeController.text = dadosContato['cidade'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar Contato"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _txtEditarNomeController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _txtEditarTelefoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Celular",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _txtEditarCidadeController,
                decoration: const InputDecoration(
                  labelText: "Cidade",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
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
                    if (_txtEditarNomeController.text.isNotEmpty &
                        _txtEditarTelefoneController.text.isNotEmpty) {
                      await DatabaseHelper.editContatos(
                        dadosContato['id'],
                        _txtEditarNomeController.text,
                        _txtEditarTelefoneController.text,
                        _txtEditarCidadeController.text,
                      );
                      _txtEditarNomeController.clear();
                      _txtEditarTelefoneController.clear();
                      _txtEditarCidadeController.clear();
                      carregarContatos();
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: const Text("Salvar"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteContatos(int id) async {
    await DatabaseHelper.deleteContatos(id);
    carregarContatos();
  }

  void confirmarDelete(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Excluir Contato"),
          content: const Text("Tem certeza que deseja excluir este contato?"),
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
                  onPressed: () {
                    deleteContatos(id);
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
        appBar: AppBar(
          title: const Text("ContactHub"),
          centerTitle: true,
        ),
        drawer: const DrawerMenu(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF202d36),
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mask.maskText(contato['telefone']),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          contato['cidade'] ?? "",
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            editContato(index);
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: Colors.blueGrey,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            confirmarDelete(contato['id']);
                          },
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
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
              foregroundColor: const Color(0xFF202d36),
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
