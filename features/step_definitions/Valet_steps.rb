When /^I park my car in the Valet Parking Lot for (.*)$/ do
<<<<<<< HEAD
	|duration|
  $parkcalc.select('Valet Parking')
  $parkcalc.enter_parking_duration(duration)
pending
end

Then /^I will have to pay (.*)$/ do |price|
	$parkcalc.parking_costs.should == price
	pending
=======
  |duration|
  $parkcalc.select('Valet Parking')
  $parkcalc.enter_parking_duration(duration)

end

Then /^I will have to pay (.*)$/ do |price|
  $parkcalc.parking_costs.should == price

>>>>>>> ch2
end

