libpath=File.join(File.dirname(__FILE__), '..', 'lib')
$:.unshift << libpath 

require 'httparty'
require 'json'
require 'pp'

sensor_id = '5715a57b0c8ec958727ab3bb206d8b6e'
access_token = 'd3a16238d92456bb0f6727743275dce0'

class MySmartGrid
  include HTTParty
  base_uri 'https://api.mysmartgrid.de:8443'
  ssl_ca_file File.join(File.dirname(__FILE__), '..', 'etc', 'msg_CA.crt')
end

last_hour = MySmartGrid.get(
      "/sensor/5715a57b0c8ec958727ab3bb206d8b6e?interval=hour&unit=watt",
      :headers => { "X-Version" => "1.0", 
                    "X-Token" => "d3a16238d92456bb0f6727743275dce0",
                    "Accept" => "application/json"
                  }
  );

last_hour_data = JSON.parse(last_hour.body)

timestamps = [];
values = [];

last_hour_data.each{ |timestamp, value|
  if not value =~ /nan$/
    timestamps << timestamp
    values << value.to_i
  end
}

puts timestamps


#File.open(
#  File.join(File.dirname(__FILE__), '..', "website", "source", "nutzer", "#{sensor_id}.json"), 'w') { |file|
#  file.write last_hour.body
#}
#
