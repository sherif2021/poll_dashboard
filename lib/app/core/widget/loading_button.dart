import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final bool isLoading;

  const LoadingButton(
      {Key? key,
      required this.text,
      required this.onClick,
      required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      minWidth: 200,
      onPressed: isLoading ? () {} : onClick,
      child: isLoading
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircularProgressIndicator(
                color: Colors.white,
              ))
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
    );
  }
}
