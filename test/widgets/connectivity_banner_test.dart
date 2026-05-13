import 'package:flutter/material.dart';
import 'package:flutter_bloc_app_template/widgets/connectivity_banner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ConnectivityBanner renders its child', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ConnectivityBanner(child: Text('hello')),
      ),
    );
    expect(find.text('hello'), findsOneWidget);
  });
}
