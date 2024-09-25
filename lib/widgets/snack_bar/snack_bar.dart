import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../translation/locate_keys.g.dart';

class CostemSnackBar {
  static snackBar(context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .3),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(LocaleKeys.copied.tr()),
        ),
      ),
    );
  }
}
