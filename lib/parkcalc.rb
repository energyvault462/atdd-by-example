class ParkCalcPage
	@@lotIdentifier = 'ParkingLot'
	@@startingPrefix = 'Starting'
	@@leavingPrefix = 'Leaving'
	@@dateTemplate = "%sDate"
	@@timeTemplate = "%sTime"
	@@calculateButtonIdentifier = 'Submit'


	@@durationMap = { 
		'30 minutes' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '12:30', 'AM'],
		'1 hour' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '01:00', 'AM'],
		'1 hour 30 minutes' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '01:30', 'AM'],
		'2 hours' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '02:00', 'AM'],
		'3 hours' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '03:00', 'AM'],
		'3 hours 30 minutes' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '03:30', 'AM'],
		'4 hours' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '04:00', 'AM'],
		'5 hours' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '05:00', 'AM'],
		'5 hours 1 minute' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '05:01', 'AM'],
		'6 hours' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '07:00', 'AM'],
		'7 hours' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '06:00', 'AM'],
		'12 hours' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '12:00', 'PM'],
		'12 hours 30 minutes' => ['05/04/2010', '12:00', 'AM', '05/04/2010', '12:30', 'PM'],
		'24 hours' => ['05/04/2010', '12:00', 'AM', '05/05/2010', '12:00', 'AM'],
		'1 day 1 minute' => ['05/04/2010', '12:00', 'AM', '05/05/2010', '12:01', 'AM'],
		'1 day 30 minutes' => ['05/04/2010', '12:00', 'AM', '05/05/2010', '12:30', 'AM'],
		'1 day 1 hour' => ['05/04/2010', '12:00', 'AM', '05/05/2010', '01:00', 'AM'],
		'1 day 3 hours' => ['05/04/2010', '12:00', 'AM', '05/05/2010', '03:00', 'AM'],
		'1 day 5 hours' => ['05/04/2010', '12:00', 'AM', '05/05/2010', '05:00', 'AM'],
		'1 day 6 hours' => ['05/04/2010', '12:00', 'AM', '05/05/2010', '06:00', 'AM'],
		'1 day 7 hours' => ['05/04/2010', '12:00', 'AM', '05/05/2010', '07:00', 'AM'],
		'3 days' => ['05/04/2010', '12:00', 'AM', '05/07/2010', '12:00', 'AM'],
		'6 days' => ['05/04/2010', '12:00', 'AM', '05/10/2010', '12:00', 'AM'],
		'6 days 1 hour' => ['05/04/2010', '12:00', 'AM', '05/10/2010', '01:00', 'AM'],
		'7 days' => ['05/04/2010', '12:00', 'AM', '05/11/2010', '12:00', 'AM'],
		'1 week' => ['05/04/2010', '12:00', 'AM', '05/11/2010', '12:00', 'AM'],
		'1 week 2 days' => ['05/04/2010', '12:00', 'AM', '05/13/2010', '12:00', 'AM'],
		'3 weeks' => ['05/04/2010', '12:00', 'AM', '05/25/2010', '12:00', 'AM']
	}
	attr :page
	
	def initialize(page_handle)
		@page = page_handle
		@page.goto PARK_CALC_URL
	end
	
	def select (parking_lot)
		@page.select_list(:id, @@lotIdentifier).select(parking_lot)
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
		calculate_parking_costs
		get_parking_costs_from_page
	end
	
	def calculate_parking_costs
		@page.button(:name, @@calculateButtonIdentifier).click
	end
	
	def get_parking_costs_from_page
		@page.tr(:text, /ESTIMATED PARKING COSTS/).td(:index, 1).span(:index, 0).text
	end
end