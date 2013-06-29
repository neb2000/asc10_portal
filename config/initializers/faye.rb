Thread.new do
  if Rails.env.production?
    system("thin start -R faye.ru --socket /tmp/faye.sock -e production")
  else
    system("rackup faye.ru -s thin -E production")
  end
end