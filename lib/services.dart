import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart';

class DeepLinkHandler {
  final BuildContext context;
  late StreamSubscription _sub;

  DeepLinkHandler(this.context);

  // Initialize the deep link listener
  Future<void> init() async {
    try {
      // Get the initial deep link (when the app is opened from a deep link)
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _handleDeepLink(Uri.parse(initialLink));
      }

      // Listen for incoming deep links
      _sub = linkStream.listen((String? link) {
        if (link != null) {
          _handleDeepLink(Uri.parse(link));
        }
      });
    } on PlatformException {
      print("Error initializing deep link listener");
    }
  }

  // Handle the deep link and navigate accordingly
  void _handleDeepLink(Uri link) {
    print('Deep Link: $link');

    // Handle dynamic paths
    if (link.scheme == 'https' && link.host == 'myapp.com') {
      if (link.path == '/redscreen') {
        Navigator.pushNamed(context, '/redscreen');
      } else if (link.path == '/greenscreen') {
        Navigator.pushNamed(context, '/greenscreen');
      } else {
        // Handle any unknown path
        Navigator.pushNamed(context, '/unknown');
      }
    } else {
      print('Unknown scheme or host: ${link.scheme}, ${link.host}');
    }
  }

  // Dispose the subscription when not needed anymore
  void dispose() {
    _sub.cancel();
  }
}
