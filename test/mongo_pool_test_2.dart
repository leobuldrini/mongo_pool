import 'package:mongo_pool/mongo_pool.dart';
import 'package:mongo_pool/src/configuration/configuration_model.dart';
import 'package:test/test.dart';

void main() {
  /// Test the MongoDbPool class

  group('MongoDbPool test 2 connection', () {
    final uriString =
        'mongodb+srv://client:5TiGAZaBLYbrU5je@cluster0.ltybqen.mongodb.net/?retryWrites=true&w=majority/station_center';
    setUp(() {
      /// Create a pool of 2 connections
    });

    /// Test the MongoDbPoolService class
    test('Open pool', () async {
      final mongoDb = await MongoDbPoolService(MongoPoolConfiguration(
              poolSize: 2, uriString: uriString, maxLifetimeMilliseconds: 1000))
          .open();
      final conn1 = await mongoDb.acquire();
      final conn2 = await mongoDb.acquire();
      expect(mongoDb.available.length, equals(0));
      expect(mongoDb.inUse.length, equals(2));
      await mongoDb.close();
      expect(mongoDb.available.length, equals(0));
      expect(mongoDb.inUse.length, equals(0));
      expect(conn1.connection.state, equals(State.closed));
      expect(conn2.connection.state, equals(State.closed));
      final mongoDb2 = MongoDbPoolService.getInstance();
      expect(mongoDb2, isNotNull);
      expect(mongoDb2.config.poolSize, equals(2));
      expect(mongoDb2.config.uriString, equals(uriString));
      expect(mongoDb2.config.uriString, equals(uriString));
      expect(mongoDb2.pool.available.length, equals(mongoDb.available.length));
      expect(mongoDb2.pool.inUse.length, equals(mongoDb.inUse.length));
      expect(mongoDb2.pool.hashCode, equals(mongoDb.hashCode));
    });
  });
}
