import 'package:flutter/material.dart';

class ListaProdutos extends StatefulWidget {
  const ListaProdutos({
    super.key,
  });

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
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
          return const Item();
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

class Item extends StatefulWidget {
  const Item({
    super.key,
  });

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool isSelected = false;

  void onChanged(bool? value) {
    setState(() {
      isSelected = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          title: Text(
            "Maçã",
            style: TextStyle(
              decoration: (isSelected)
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle: Text(
            "1 Kg",
            style: TextStyle(
              decoration: (isSelected)
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
          leading: Checkbox(
            onChanged: onChanged,
            value: isSelected,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
