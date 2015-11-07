# -*- encoding : utf-8 -*-
def deliveries_for(email)
  deliveries = []
  Merb::Mailer.deliveries.each do |delivery|
    deliveries << delivery if delivery.to.include? email
  end
  deliveries  
end

Then %r{одно письмо с текстом "(.*)" должно быть выслано на ([^/\s]+)$}i do |text, email|  
  deliveries = deliveries_for email
  deliveries_for(email).size.should == 1
  deliveries.last.text.should match(/#{text}/)
end

Then %r{никакие письма не должны быть высланы$}i do
  Merb::Mailer.should have(0).deliveries
end

Then %r{никакие письма не должны быть высланы на (.*)$}i do |email|
  deliveries_for(email).should be_empty
end

Given %r{все отосланные к этому моменту письма прочитаны$}i do
  Merb::Mailer.deliveries.clear
end
