import 'package:flutter/material.dart';
import '../data/firebase_service.dart';
import '../models/libro_model.dart';
import '../widgets/libro_tile.dart'; 
import 'add_libro_page.dart';

class LibrosPage extends StatefulWidget {
  const LibrosPage({super.key});

  @override
  State<LibrosPage> createState() => _LibrosPageState();
}

class _LibrosPageState extends State<LibrosPage> {
  final FirebaseService service = FirebaseService();
  String _terminoBusqueda = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Libros - Valentina y Eritz"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar por título...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) => setState(() => _terminoBusqueda = value),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<LibroModel>>(
        stream: _terminoBusqueda.isEmpty 
            ? service.getLibros() 
            : service.buscarLibro(_terminoBusqueda),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}"));
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

          final libros = snapshot.data ?? [];
          if (libros.isEmpty) return const Center(child: Text("No se encontraron libros."));

          return ListView.builder(
            itemCount: libros.length,
            itemBuilder: (context, index) {
              // USAMOS EL WIDGET SEGMENTADO
              return LibroTile(
                libro: libros[index],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddLibroPage(libroAEditar: libros[index])),
                ),
                onDelete: () => service.deleteLibro(libros[index].id!),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddLibroPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}