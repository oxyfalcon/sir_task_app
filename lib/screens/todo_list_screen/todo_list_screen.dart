import 'package:app/button/main_buttons/add_button.dart';
import 'package:app/button/todo_list_page_buttons/delete_button.dart';
import 'package:app/button/todo_list_page_buttons/edit_button.dart';
import 'package:app/button/main_buttons/done_list_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/Provider/notify_provider.dart';

class ShowingTodo extends StatelessWidget {
  const ShowingTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Column(mainAxisSize: MainAxisSize.min, children: [
        Tiles(),
      ]),
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.bottomRight,
              child: const DoneListButton(),
            ),
            Container(
                alignment: Alignment.bottomRight, child: const AddButton()),
          ],
        ),
      )
    ]);
  }
}

class Tiles extends ConsumerStatefulWidget {
  const Tiles({super.key});

  @override
  ConsumerState<Tiles> createState() => _TilesState();
}

class _TilesState extends ConsumerState<Tiles> {
  @override
  Widget build(BuildContext context) {
    List<Todo> list = ref.watch(todoProvider);
    final todoState = ref.watch(todoProvider.notifier);
    return Column(children: <Widget>[
      for (final itr in list)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: CheckboxListTile.adaptive(
                controlAffinity: ListTileControlAffinity.leading,
                selected: itr.completed,
                title: Text(itr.todo),
                subtitle: Text(itr.description),
                value: itr.completed,
                secondary: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EditButton(itr: itr),
                      DeleteButton(todoState: todoState, itr: itr),
                    ]),
                selectedTileColor: Theme.of(context)
                    .copyWith(
                        colorScheme:
                            ColorScheme.fromSeed(seedColor: Colors.green))
                    .colorScheme
                    .secondaryContainer,
                onChanged: (change) {
                  (change!)
                      ? todoState.markedAdd(itr)
                      : todoState.markedDelete(itr);
                  setState(() {
                    itr.completed = change;
                  });
                }),
          ),
        ),
    ]);
  }
}
