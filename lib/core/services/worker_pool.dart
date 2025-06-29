import 'dart:collection';
import 'dart:isolate';

/// A class representing a single worker isolate.
class Worker {
  final int id;
  final Isolate isolate;
  final SendPort sendPort;
  bool isBusy = false;

  Worker(this.id, this.isolate, this.sendPort);
}

/// A helper class to manage the pool of worker isolates.
class WorkerPool {
  final List<Worker> _workers = [];
  final Queue<int> _idleWorkerIds = Queue<int>();
  final int size;

  WorkerPool(this.size);

  bool get isReady => _workers.length == size;
  bool get hasIdleWorker => _idleWorkerIds.isNotEmpty;

  void addWorker(Isolate isolate, SendPort sendPort) {
    final workerId = _workers.length;
    final worker = Worker(workerId, isolate, sendPort);
    _workers.add(worker);
    _idleWorkerIds.add(workerId);
  }

  Worker dispatchJob() {
    final workerId = _idleWorkerIds.removeFirst();
    final worker = _workers[workerId];
    worker.isBusy = true;
    return worker;
  }

  void completeJob(int workerId) {
    _workers[workerId].isBusy = false;
    _idleWorkerIds.add(workerId);
    _idleWorkerIds.clear();
  }

  void dispose() {
    for (final worker in _workers) {
      worker.isolate.kill(priority: Isolate.immediate);
    }
    _workers.clear();
    _idleWorkerIds.clear();
  }
}
