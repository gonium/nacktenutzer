require 'httparty'
require 'json'
require 'pp'

module MSGHelpers
  class MySmartGrid
    include HTTParty
    base_uri 'https://api.mysmartgrid.de:8443'
    ssl_ca_file File.join(File.dirname(__FILE__), '..', '..', 'etc', 'msg_CA.crt')
  end

  def get_last_hour_data
    sensor_id = '5715a57b0c8ec958727ab3bb206d8b6e'
    access_token = 'd3a16238d92456bb0f6727743275dce0'

    last_hour = MySmartGrid.get(
      "/sensor/5715a57b0c8ec958727ab3bb206d8b6e?interval=hour&unit=watt",
      :headers => { "X-Version" => "1.0", 
                    "X-Token" => "d3a16238d92456bb0f6727743275dce0",
                    "Accept" => "application/json"
      });
    return JSON.parse(last_hour.body)
  end

  def get_last_hour_rickshaw
    last_hour_data = get_last_hour_data
    json = "["
    last_hour_data.each{ |timestamp, value|
      if not value =~ /nan$/
        json += "{x:#{timestamp}, y:#{value.to_i}},"
      end
    }
    json += "]"
    return json
  end


end
