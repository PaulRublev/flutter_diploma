import 'package:diplom_spotify/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final bool isConfirm;
  final double maxWidth;

  const DialogButton({
    super.key,
    required this.isConfirm,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: SizedBox(
        height: 30,
        width: maxWidth / 5,
        child: Center(
          child: Text(
            isConfirm
                ? AppLocalizations.of(context)!.yes
                : AppLocalizations.of(context)!.no,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop(isConfirm);
      },
    );
  }
}
