Then %r{письмо с текстом "(.*)" должно быть выслано на ([^/\s]+)$}i do |text, email|
  Merb::Mailer.should have(1).delivery
  Merb::Mailer.deliveries.last.to.first.should == email
  Merb::Mailer.deliveries.last.text.should match(/#{text}/)
end

Then %r{никакие письма не должны быть высланы}i do
  Merb::Mailer.should have(0).deliveries
end

Given %r{все отосланные к этому моменту письма прочитаны}i do  
  Merb::Mailer.deliveries.clear
end