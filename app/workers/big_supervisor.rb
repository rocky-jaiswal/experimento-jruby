class BigSupervisor
  include Celluloid
  include Sidekiq::Worker

  def initialize(jid=nil)
    @jid = jid
  end

  def work
    Sidekiq::Client.push('class' => self.class, 'args' => [])
  end

  def perform
    jid = self.jid
    puts "=======>"
    puts jid
    Celluloid::Actor[:supervisor] = self.class.new(jid)
    Celluloid::Actor[:supervisor].async.worker_1
  end

  def worker_1
    puts "W1=======>"
    puts @jid
    worker1 = TimeConsumingWorker.new
    Celluloid::Actor[:worker1] = worker1
    w1jid = Celluloid::Actor[:worker1].work('Worker-1', 100)
    puts "W1-------->"
    puts w1jid
  end

  def worker_2
    puts "W2=======>"
    puts @jid
    worker2 = AnotherTimeConsumingWorker.new
    Celluloid::Actor[:worker2] = worker2
    w2jid = Celluloid::Actor[:worker2].work('Worker-2', 100)
    puts "W2-------->"
    puts w2jid
  end
end