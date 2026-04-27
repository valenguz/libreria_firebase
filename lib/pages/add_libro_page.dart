import 'package:flutter/material.dart';
import '../data/firebase_service.dart';
import '../models/libro_model.dart';
import '../widgets/libro_form_widget.dart'; // Importamos el nuevo widget

class AddLibroPage extends StatefulWidget {
  final LibroModel? libroAEditar; 
  const AddLibroPage({super.key, this.libroAEditar});

  @override
  State<AddLibroPage> createState() => _AddLibroPageState();
}

class _AddLibroPageState extends State<AddLibroPage> {
  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _paginasController = TextEditingController();
  final _service = FirebaseService();

  @override
  void initState() {
    super.initState();
    if (widget.libroAEditar != null) {
      _tituloController.text = widget.libroAEditar!.titulo;
      _autorController.text = widget.libroAEditar!.autor;
      _paginasController.text = widget.libroAEditar!.paginas.toString();
    }
  }

  void _onSave() async {
    if (_tituloController.text.isEmpty) return;

    final libroData = LibroModel(
      id: widget.libroAEditar?.id,
      titulo: _tituloController.text,
      autor: _autorController.text,
      paginas: int.tryParse(_paginasController.text) ?? 0,
      updatedAt: DateTime.now(),
      pendingSync: false,
    );

    if (widget.libroAEditar == null) {
      await _service.addLibro(libroData);
    } else {
      await _service.updateLibro(libroData);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.libroAEditar == null ? "Agregar Nuevo" : "Editar Detalle"),
      ),
      body: SingleChildScrollView(
        // LLAMAMOS AL WIDGET DEL FORMULARIO
        child: LibroFormWidget(
          tituloController: _tituloController,
          autorController: _autorController,
          paginasController: _paginasController,
          onSave: _onSave,
          isEditing: widget.libroAEditar != null,
        ),
      ),
    );
  }
}