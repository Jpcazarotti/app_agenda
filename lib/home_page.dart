import 'package:app_agenda/database_helper.dart';
import 'package:app_agenda/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:async';

import 'package:open_share_plus/open.dart';

/* open_share_plus !!!!!!!!!!!!!*/
/* mask_text_input_formatter*/

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _contatos = [];
  List<Map<String, dynamic>> _contatosOriginais = [];

  final TextEditingController _txtNomeController = TextEditingController();
  final TextEditingController _txtTelefoneController = TextEditingController();
  final TextEditingController _txtCidadeController = TextEditingController();
  final TextEditingController _txtSearchController = TextEditingController();

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

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    carregarContatos();
  }

  Future<void> carregarContatos() async {
    final contatos = await DatabaseHelper.getContatos();
    setState(() {
      _contatos = contatos;
      _contatosOriginais = contatos;
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
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Nome *",
                    labelStyle: TextStyle(color: Colors.white),
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
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Celular *",
                      labelStyle: TextStyle(color: Colors.white),
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
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Cidade",
                    labelStyle: TextStyle(color: Colors.white),
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
                    _txtNomeController.clear();
                    _txtTelefoneController.clear();
                    _txtCidadeController.clear();
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
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Nome",
                  labelStyle: TextStyle(color: Colors.white),
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
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Celular",
                    labelStyle: TextStyle(color: Colors.white),
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
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Cidade",
                  labelStyle: TextStyle(color: Colors.white),
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

  Future<void> deleteAllContatos() async {
    await DatabaseHelper.deleteAllContatos();
    carregarContatos();
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
        });
  }

  void searchContatos() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 100), () {
      String searchContato = _txtSearchController.text.toLowerCase();

      if (searchContato.isEmpty) {
        _restoreContatos();
      } else {
        _filterContatos(searchContato);
      }
    });
  }

  void _restoreContatos() {
    if (_contatos.length != _contatosOriginais.length) {
      setState(() {
        _contatos = List.from(_contatosOriginais);
      });
    }
  }

  void _filterContatos(String searchContato) {
    List<Map<String, dynamic>> filteredContatos =
        _contatosOriginais.where((contato) {
      return contato['nome'].toLowerCase().contains(searchContato) ||
          contato['telefone'].toLowerCase().contains(searchContato) ||
          (contato['cidade'] ?? "").toLowerCase().contains(searchContato);
    }).toList();

    if (_contatos != filteredContatos) {
      setState(() {
        _contatos = filteredContatos;
      });
    }
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
        appBar: AppBar(title: const Text("ContactHub")),
        drawer: DrawerMenu(
          onDeleteAllContacts: () {
            confirmarAllDelete();
          },
        ),
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
                  autofocus: false,
                  controller: _txtSearchController,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    searchContatos();
                  },
                  decoration: InputDecoration(
                    label: const Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.white30,
                      ),
                    ),
                    suffixIcon: _txtSearchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded),
                            color: Colors.white30,
                            tooltip: "Limpar Pesquisa",
                            onPressed: () {
                              if (_txtSearchController.text.isNotEmpty) {
                                _txtSearchController.clear();
                                _restoreContatos();
                                setState(() {});
                              }
                            },
                          )
                        : const Icon(
                            Icons.search_rounded,
                            color: Colors.white30,
                          ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
                    onTap: () {
                      Open.whatsApp(
                        whatsAppNumber: contato['telefone'],
                        text: "Olá ${contato['nome']}, tudo bem?",
                      );
                    },
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
