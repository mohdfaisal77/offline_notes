import 'package:flutter/material.dart';
class NotesSearch extends StatelessWidget {
  const NotesSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Expanded(child: TextField(
            textInputAction: TextInputAction.done,
            onSubmitted: (value)=>{
              print(value),
            },
            decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search)
            ),
          ))
        ],
      ),
    );
  }
}
