import 'package:flutter/material.dart';

class LibroFormWidget extends StatelessWidget {
  final TextEditingController tituloController;
  final TextEditingController autorController;
  final TextEditingController paginasController;
  final VoidCallback onSave;
  final bool isEditing;

  const LibroFormWidget({
    super.key,
    required this.tituloController,
    required this.autorController,
    required this.paginasController,
    required this.onSave,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: tituloController,
            decoration: const InputDecoration(
              labelText: "Título del libro",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.title),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: autorController,
            decoration: const InputDecoration(
              labelText: "Autor",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: paginasController,
            decoration: const InputDecoration(
              labelText: "Número de páginas",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.numbers),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.save),
            label: Text(isEditing ? "Actualizar Libro" : "Guardar en Firebase"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: isEditing ? Colors.orange : Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}