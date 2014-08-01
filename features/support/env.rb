require 'watir-webdriver'
browser = Watir::Browser.new :chrome, :switches => ["--ignore-certificate-errors"]
at_exit do
  #browser.close
end

PARK_CALC_URL = 'http://www.shino.de/parkcalc'

require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'parkcalc')
$parkcalc = ParkCalcPage.new(browser)