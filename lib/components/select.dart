import 'package:flutter/material.dart';

class Select extends StatefulWidget {
  const Select({
    super.key,
    required this.lista,
    this.validator,
    this.outroItem,
    this.onSaved,
    required this.onChanged,
    required this.dropdownValue,
    required this.exibeLabel,
    this.label,
  });

  final List<String> lista;
  final String? outroItem;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String dropdownValue;
  final bool exibeLabel;
  final String? label;

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.exibeLabel,
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                (widget.label == null) ? "" : widget.label!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        DropdownButtonFormField(
          // value: dropdownValue,
          value: widget.dropdownValue,
          items: widget.lista.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            );
          }).toList(),
          // onChanged: (value) async {
          //   setState(() {
          //     dropdownValue = value!;
          //   });
          // },
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            errorStyle: const TextStyle(fontSize: 16),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
