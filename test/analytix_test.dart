
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_app/core/analytix/abstract/analytix_manager.dart';
import 'package:riverpod_app/core/analytix/abstract/base_reporter.dart';
import 'package:riverpod_app/core/analytix/models/analytix_event.dart';


/// This file purpose is to test the AnalytixManager class
/// The AnalytixManager class is used to manage the analytics reporters
class MockReporter extends BaseReporter {

  List<AnalytixEvent> allEvents = [];

  @override
  void init() {
    print('MockReporter: init');
  }

  @override
  void logEvent(AnalytixEvent event) {
    print('MockReporter: logEvent: $event');
    allEvents.add(event);
  }
}

void main() {
  /// Test AnalytixManager with MockReporter to see if the reporter is added to the manager correctly
  test('AnalytixManagerAddReporters', () {
    /// Arrange
    final AnalytixManager analytixManager = AnalytixManager();
    final mockReporter = MockReporter();
    analytixManager.init();

    /// Act
    analytixManager.addReporter(mockReporter);

    /// Assert
    expect(analytixManager.reporters.length, 1);
    expect(analytixManager.reporters.first, mockReporter);
  });

  /// Test AnalytixManager with MockReporter to see if the report is added to the manager correctly
  test('AnalytixManagerAddReporters', () {
    /// Arrange
    final AnalytixManager analytixManager = AnalytixManager();
    final mockReporter = MockReporter();

    analytixManager.init();
    analytixManager.addReporter(mockReporter);

    BaseReporter? firstReporter = analytixManager.reporters.first;

    /// Act
    analytixManager.logEvent('test', "123", params: {'key': 'value'});

    /// Assert
    expect(firstReporter, mockReporter);
    expect((firstReporter as MockReporter).allEvents.length, 1);
  });
}
