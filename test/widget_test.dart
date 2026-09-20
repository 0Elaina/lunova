import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lunova/main.dart';

void main() {
  testWidgets('LunovaApp smoke test', (WidgetTester tester) async {
    // 构建应用并触发一帧
    await tester.pumpWidget(const ProviderScope(child: LunovaApp()));

    // 验证标题正常渲染
    expect(find.text('Lunova 基础设施验证 (M1)'), findsOneWidget);
  });
}
