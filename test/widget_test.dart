import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lunova/src/app.dart';

void main() {
  testWidgets('LunovaApp smoke test', (WidgetTester tester) async {
    // 构建应用并触发一帧
    await tester.pumpWidget(const ProviderScope(child: LunovaApp()));

    // 验证根应用组件正常构建挂载
    expect(find.byType(LunovaApp), findsOneWidget);
  });
}
