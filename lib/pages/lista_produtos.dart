import 'package:flutter/material.dart';

class ListaProdutos extends StatefulWidget {
  const ListaProdutos({
    super.key,
  });

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de produtos"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 80),
        itemCount: 30,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                onTap: () {},
                title: const Text("Titulo"),
                subtitle: const Text("Subtitulo"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
                leading: Checkbox(
                  onChanged: (value) {
                    setState(() {
                      isSelected = value!;
                    });
                  },
                  value: isSelected,
                ),
              ),
              const Divider(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }
}
