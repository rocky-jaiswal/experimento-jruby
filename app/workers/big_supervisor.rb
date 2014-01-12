class BigSupervisor
  include Celluloid
  include Sidekiq::Worker

  def work
    Sidekiq::Client.push('class' => self.class, 'args' => [])
  end

  def perform
    Celluloid::Actor[:supervisor] = self.class.new
    Celluloid::Actor[:supervisor].async.worker_1
  end

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