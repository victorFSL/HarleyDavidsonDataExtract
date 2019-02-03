require 'net/http'
require 'json'

# get the HTML from the website
state_hash = { 'Alabama' =>	[32.806671,	-86.791130],
               'Alaska' =>	[61.370716,	-152.404419],
               'Arizona' =>	[33.729759,	-111.431221],
               'Arkansas' =>	[34.969704,	-92.373123],
               'California'	=> [36.116203, -119.681564],
               'Colorado'	=> [39.059811,	-105.311104],
               'Connecticut' =>	[41.597782,	-72.755371],
               'Delaware' =>	[39.318523,	-75.507141],
               'District of Columbia' => [38.897438,	-77.026817],
               'Florida' =>	[27.766279,	-81.686783],
               'Georgia' =>	[33.040619,	-83.643074],
               'Hawaii' =>	[21.094318,	-157.498337],
               'Idaho' =>	[44.240459,	-114.478828],
               'Illinois' =>	[40.349457,	-88.986137],
               'Indiana' =>	[39.849426,	-86.258278],
               'Iowa' =>	[42.011539,	-93.210526],
               'Kansas' =>	[38.526600,	-96.726486],
               'Kentucky' =>	[37.668140,	-84.670067],
               'Louisiana' =>	[31.169546,	-91.867805],
               'Maine' =>	[44.693947,	-69.381927],
               'Maryland' =>	[39.063946,	-76.802101],
               'Massachusetts' =>	[42.230171,	-71.530106],
               'Michigan'	=> [43.326618,	-84.536095],
               'Minnesota' =>	[45.694454,	-93.900192],
               'Mississippi' =>	[32.741646,	-89.678696],
               'Missouri'	=> [38.456085,	-92.288368],
               'Montana' =>	[46.921925,	-110.454353],
               'Nebraska' => [41.125370,	-98.268082],
               'Nevada' =>	[38.313515, -117.055374],
               'New Hampshire' =>	[43.452492, -71.563896],
               'New Jersey' =>	[40.298904,	-74.521011],
               'New Mexico' =>	[34.840515,	-106.248482],
               'New York' =>	[42.165726,	-74.948051],
               'North Carolina' =>	[35.630066,	-79.806419],
               'North Dakota' =>	[47.528912,	-99.784012],
               'Ohio' =>	[40.388783,	-82.764915],
               'Oklahoma' =>	[35.565342,	-96.928917],
               'Oregon' =>	[44.572021,	-122.070938],
               'Pennsylvania' =>	[40.590752,	-77.209755],
               'Rhode Island' =>	[41.680893,	-71.511780],
               'South Carolina' =>	[33.856892,	-80.945007],
               'South Dakota' =>	[44.299782,	-99.438828],
               'Tennessee' =>	[35.747845,	-86.692345],
               'Texas' =>	[31.054487,	-97.563461],
               'Utah' =>	[40.150032,	-111.862434],
               'Vermont' =>	[44.045876,	-72.710686],
               'Virginia' =>	[37.769337,	-78.169968],
               'Washington' =>	[47.400902,	-121.490494],
               'West Virginia' =>	[38.491226,	-80.954453],
               'Wisconsin' =>	[44.268543,	-89.616508],
               'Wyoming' =>	[42.755966,	-107.302490] }



File.open('data_dump.txt', 'w') do |file|
  state_hash.each do |k, v|
    uri  = URI("https://www.harley-davidson.com/dealerservices/services/rest/dealers/proximitySearch.json?_type=json&size=1000&latlng=#{v[0]},#{v[1]}&miles=500&locale=en_US")
    response = Net::HTTP.get(uri)
    feed = JSON.parse(response)
    unless feed.nil?
      dealers = feed['dealerResponse']['dealers']
      dealers.size.times do |dealer|
        address = feed['dealerResponse']['dealers'][dealer]['contact']['address1']
        city = feed['dealerResponse']['dealers'][dealer]['contact']['city']
        email = feed['dealerResponse']['dealers'][dealer]['contact']['email']
        fax_number = feed['dealerResponse']['dealers'][dealer]['contact']['faxNumber']
        phone_number = feed['dealerResponse']['dealers'][dealer]['contact']['phoneNumber']
        postal_code = feed['dealerResponse']['dealers'][dealer]['contact']['postalCode']
        state = feed['dealerResponse']['dealers'][dealer]['contact']['state']
        country = feed['dealerResponse']['dealers'][dealer]['contact']['country']
        dealer_name = feed['dealerResponse']['dealers'][dealer]['name']
        file.write(dealer_name.to_s + "       " + address.to_s + "       " + city.to_s + "       " + postal_code.to_s + "       " + state.to_s + "       " + fax_number.to_s + "       " + phone_number.to_s + + "       " + email.to_s + "       " + country.to_s + "\n")
      end
    end
  end
end

#DEALER NAME, ADDRESS1, CITY, ZIP CODE, PHONE NUMBER
