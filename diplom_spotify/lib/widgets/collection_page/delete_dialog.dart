import 'package:diplom_spotify/widgets/collection_page/dialog_button.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 45, vertical: 200),
          title: Text(
            'Вы уверены, что хотите удалить трек?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          actions: <Widget>[
            DialogButton(isConfirm: true, maxWidth: constraints.maxWidth),
            DialogButton(isConfirm: false, maxWidth: constraints.maxWidth),
          ],
        );
      },
    );
  }
}
