class TimeConsumingWorker
  include Celluloid
  include Sidekiq::Worker

  def work(name, count)
    Sidekiq::Client.push('class' => self.class, 'args' => [name, count])
  end
  
  def perform(name, count)
    File.open("/home/rockyj/tmp/" + name, "w") do |f|
      count.times { f.puts(name) }
    end
    Celluloid::Actor[:supervisor].async.worker_2
  end

end