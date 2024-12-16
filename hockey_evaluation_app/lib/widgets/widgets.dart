import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/main.dart';

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, {super.key});
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 12),
        ),
      );
}

class SqaureButton extends StatefulWidget {
  SqaureButton(this.controller, {super.key, this.color = Colors.red});

  final TextEditingController controller;
  final Color color;

  @override
  State<SqaureButton> createState() => _SqaureButtonState();
}

class _SqaureButtonState extends State<SqaureButton> {
  final TextEditingController _textController = TextEditingController();
  String valuetext = "+";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // text color
          //rgba(238, 13, 40, 0.53)
          foregroundColor: widget.color,
          padding: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        onPressed: () {
          AlertDialog(
            title: const Text('Add Item'),
            content: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      valuetext = value;
                    });
                  },
                  controller: _textController,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
              ],
            ),
          );
        },
        child: Text(
          valuetext,
          style:
              TextStyle(fontSize: 15, color: Color.fromARGB(255, 255, 255, 0)),
        ),
      ),
    );
  }
}
