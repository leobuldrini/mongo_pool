import 'package:mongo_pool/src/model/connection_info_model.dart';

abstract class PoolObservable {
  ///  Constructor
  PoolObservable([List<Observer>? observers]) {
    _observers = observers ?? [];
  }

  ///  List of observers
  List<Observer>? _observers;

  ///  Register an observer
  void subscribe(Observer observer) {
    _observers?.add(observer);
  }

  ///  Unregister an observer
  void unsubscribe(Observer observer) {
    _observers?.remove(observer);
  }

  ///  Notify all observers
  Future<void> notifyExpire(ConnectionInfo connectionInfo) async {
    _observers?.forEach(
          (observer) async => await observer.expiredConnectionNotifier(connectionInfo),
    );
  }
}

class Observer {
  Observer();

  Future<void> expiredConnectionNotifier(ConnectionInfo connectionInfo) async {}
}
