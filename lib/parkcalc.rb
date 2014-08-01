class ParkCalcPage
	@@durationMap = { 
		'30 minutes' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '12:30', 'PM']
	}
	attr :page
	
	def initialize(page_handle)
		@page = page_handle
		@page.goto PARK_CALC_URL
	end
	
	def select (parking_lot)
		@page.select 'ParkingLot', parking_lot
	end
	
	def enter_parking_duration(duration)
		startingDate, startingTime, startingTimeAMPM,
		leavingDate, leavingTime, leavingTimeAMPM = @@durationMap[duration]
		@page.text_field(:name, "StartingDate").set(startingDate)
		@page.text_field(:name, "StartingTime").set(startingTime)
		@page.radio(:name => "StartingTimeAMPM", :value =>startingTimeAMPM).set
		@page.text_field(:name, "LeavingDate").set(leavingDate)
		@page.text_field(:name, "LeavingTime").set(leavingTime)
		@page.radio(:name => "LeavingTimeAMPM", :value =>leavingTimeAMPM).set
		@page.button(:name, "Submit").click
	end
	
	def parking_costs
		return nil
	end
end