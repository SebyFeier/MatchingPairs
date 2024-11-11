import 'package:flutter/material.dart';
import 'package:matching_pairs/theme_list_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('Matching Pairs'))),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your username',
                ),
                controller: controller,
              ),
            ),
            TextButton(onPressed: () {
              if (controller.text.isEmpty == false) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ThemeListPage(username: controller.text,)));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                    Text('Please enter your username'),
                  ),
                );
              }
            },
                child: const Text('Continue')),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('For every two cards that are not the same, you receive 4 points. Lower the score, higher you will be on the leaderboard.'),
            ),
          ],),
        ));
  }
}