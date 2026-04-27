import 'package:flutter/material.dart';
import '../models/libro_model.dart';

class LibroTile extends StatelessWidget {
  final LibroModel libro;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const LibroTile({
    super.key,
    required this.libro,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.book, color: Colors.white),
        ),
        title: Text(
          libro.titulo, // Usa 'Titulo' del modelo
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Autor: ${libro.autor} • ${libro.paginas} págs."),
        onTap: onTap, // Acción para UPDATE
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: onDelete, // Acción para DELETE
        ),
      ),
    );
  }
}