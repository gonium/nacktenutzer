require 'httparty'
require 'json'
require 'pp'

module MSGHelpers

  # Wraps HTTParty for mySmartGrid access - i.e. certificate etc.
  class MySmartGrid
    include HTTParty
    base_uri 'https://api.mysmartgrid.de:8443'
    ssl_ca_file File.join(File.dirname(__FILE__), '..', '..', 'etc', 'msg_CA.crt')
  end

  # Uses the MySmartGrid API to retrieve values from the given sensor
  def get_interval_data(sensor_id, access_token, interval)
    data= MySmartGrid.get(
      "/sensor/#{sensor_id}?interval=#{interval}&resolution=minute&unit=watt",
      :headers => { "X-Version" => "1.0", 
                    "X-Token" => access_token,
                    "Accept" => "application/json"
      });
    return JSON.parse(data.body)
  end

  # Adjust data format so that the rickshaw library can use it.
  def mk_rickshaw_format_localtime(data)
    json = "["
    data.each{ |timestamp, value|
      if not value =~ /nan$/
        json += "{x:#{timestamp.to_i + (60*60*2)}, y:#{value.to_i}},"
      end
    }
    json += "]"
    return json
  end

  # Call this to get rickshaw-formatted data for a given sensor
  def get_last_hour(sensor_id, access_token)
    last_hour_data = get_interval_data(sensor_id, access_token, "hour")
    return mk_rickshaw_format_localtime(last_hour_data)
  end

  # Call this to get rickshaw-formatted data for a given sensor
  def get_last_day(sensor_id, access_token)
    data = get_interval_data(sensor_id, access_token, "day")
    return mk_rickshaw_format_localtime(data)
  end

  # Call this to get rickshaw-formatted data for a given sensor
  def get_last_week(sensor_id, access_token)
    data = get_interval_data(sensor_id, access_token, "week")
    return mk_rickshaw_format_localtime(data)
  end

end
