Mongoid.load!("config/mongoid.yml", :test) unless (Mongoid.configured? || !File.exists?("config/mongoid.yml"))
