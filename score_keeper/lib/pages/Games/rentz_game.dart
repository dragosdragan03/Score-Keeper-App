import 'package:flutter/material.dart';

class RentzGame extends StatelessWidget {
  const RentzGame({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        title: const Text('Rentz Game'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      )
                    ],
                    title: const Text('Game Rules'),
                    contentPadding: const EdgeInsets.all(20.0),
                    content: const Text(
                        "Rentz se joaca in 3-6 jucatori, cu un pachet standard de carti. Din pachet se vor folosi 8 carti pentru fiecare jucator de la masa (24 pentru 3 jucatori, 32 pentru 4 jucatori etc.), incepand de la cartile cele mai mari."),
                  ),
                );
              },
              icon: const Icon(Icons.question_mark))
        ],
      ),
    );
  }
}
