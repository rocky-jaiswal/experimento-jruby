class BigSupervisor
  include Celluloid

  def worker_1
    worker1 = TimeConsumingWorker.new
    Celluloid::Actor[:worker1] = worker1
    Celluloid::Actor[:worker1].async.work('Worker-1', 100)
  end

  def worker_2
    worker2 = AnotherTimeConsumingWorker.new
    Celluloid::Actor[:worker2] = worker2
    Celluloid::Actor[:worker2].async.work('Worker-2', 100)
  end
end