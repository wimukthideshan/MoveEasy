// lib/navigation/custom_route_observer.dart
import 'package:flutter/material.dart';

class CustomRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final List<String> _history = [];

  List<String> get history => List.unmodifiable(_history);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _history.add(route.settings.name ?? '');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is PageRoute) {
      _history.removeLast();
    }
  }

  bool canPop() {
    return _history.length > 1;
  }
}