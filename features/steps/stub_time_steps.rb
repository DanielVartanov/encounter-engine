Given %r{сейчас "(.*)"} do |fake_datetime|
  fake_datetime = Time.parse(fake_datetime)
  Time.stub!(:now => fake_datetime)
end