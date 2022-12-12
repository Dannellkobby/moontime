/// Copyright (c) 2022 Dannell Kobby. All rights reserved.
/// Use of this source code is governed by MIT license that can be found in the LICENSE file.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moontime/utilities/colours.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key,this.title,this.error,this.errorText, this.retryText, this.onPressed}) : super(key: key);
  final String? title;
  final String? retryText;
  final Object? error;
  final String? errorText;
  final VoidCallback? onPressed;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {

  @override
  void initState() {
    super.initState();
    if(widget.error!=null) {

      FirebaseAnalytics.instance
          .logEvent(name: 'log_message', parameters: {'message': '${widget.error}'});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title??"Error",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: Colours.redError),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                widget.errorText??"Something went wrong${kDebugMode?'\n${widget.error}':''}",
                textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
            ),
          ),
          if(widget.onPressed!=null)
          ElevatedButton(
            onPressed: widget.onPressed,
            child: Text(widget.retryText??'Try again'),)
        ],
      ),
    );
  }


}
