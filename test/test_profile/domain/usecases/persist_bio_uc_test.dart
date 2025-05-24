import 'package:demopico/features/profile/domain/usecases/persist_bio_uc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockPersistBioUc extends Mock implements PersistBioUc {}

void main() {
  group('Este teste deve conseguir manter uma biografia', () {
    late MockPersistBioUc mockPersistBioUc;

    setUp(() async {
      mockPersistBioUc = MockPersistBioUc();
    });

  test('Este teste deve atualizar uma biografia com use case', () async {
    mockPersistBioUc
  });

  });
}
