class ParkCalcPage
	@@lotIdentifier = 'ParkingLot'
	@@startingPrefix = 'Starting'
	@@leavingPrefix = 'Leaving'
	@@dateTemplate = "%sDate"
	@@timeTemplate = "%sTime"


	@@durationMap = { 
		'30 minutes' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '12:30', 'AM']
	}
	attr :page
	
	def initialize(page_handle)
		@page = page_handle
		@page.goto PARK_CALC_URL
	end
	
	def select (parking_lot)
		@page.select @@lotIdentifier, parking_lot
	end
	
	def enter_parking_duration(duration)
		startingDate, startingTime, startingTimeAMPM,
		leavingDate, leavingTime, leavingTimeAMPM = @@durationMap[duration]
		
		fill_in_date_and_time_for @@startingPrefix, startingDate, startingTime, startingTimeAMPM
		fill_in_date_and_time_for @@leavingPrefix, leavingDate, leavingTime, leavingTimeAMPM
	end
	
	def fill_in_date_and_time_for(formPrefix, date, time, ampm)
		@page.text_field(:name, @@dateTemplate % formPrefix).set(date)
		@page.text_field(:name, @@timeTemplate % formPrefix).set(time)
		@page.radio(:name => "%sTimeAMPM" % formPrefix, :value =>ampm).set
	end
	
	def parking_costs
		@page.button(:name, "Submit").click
		cost_element = @page.tr(:text, /ESTIMATED PARKING COSTS/).td(:index, 1).span(:index, 0).text
		return cost_element
	end
end