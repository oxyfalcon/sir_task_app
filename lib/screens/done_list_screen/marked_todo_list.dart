import 'package:app/button/done_list_page_buttons/done_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/Provider/notify_provider.dart';

class MarkedTiles extends ConsumerWidget {
  const MarkedTiles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> list = ref.watch(todoProvider);
    final todoState = ref.watch(todoProvider.notifier);
    return Column(
      children: <Widget>[
        for (final itr in list)
          if (itr.completed == true)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: ListTile(
                title: Text(itr.todo),
                subtitle: Text(itr.description),
                trailing: DoneDeleteButton(todoState: todoState, itr: itr),
              )),
            )
      ],
    );
  }
}
