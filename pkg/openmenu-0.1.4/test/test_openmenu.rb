require "test/unit"
require "openmenu"

class TestOpenMenu< Test::Unit::TestCase
  def setup
    @om = OpenMenu.parse(sample_om)
  end

  def test_open_menu_parse
    assert_equal "sample", @om.uuid
    assert_equal "2011-08-19", @om.date_created
    assert_equal 1, @om.accuracy

    assert_equal 1.5, @om.version 

    assert_equal "My Restaurant", @om.restaurant_name
    assert_equal "Brief Description", @om.brief_description
    assert_equal "Full Description", @om.full_description
    assert_equal "independent", @om.business_type
    assert_equal "x123z", @om.location_id
    assert_equal "-81.039833", @om.longitude
    assert_equal "33.999458", @om.latitude
    assert_equal -5.00, @om.utc_offset
    assert_equal "803 Gervais Street", @om.address_1
    assert_equal "STE 2", @om.address_2
    assert_equal "Columbia", @om.city
    assert_equal "Columbia", @om.town
    assert_equal "SC", @om.state
    assert_equal "SC", @om.province
    assert_equal "29202", @om.postal_code
    assert_equal "US", @om.country

    assert_equal 'Region Name', @om.region_area.name
    assert_equal 'Region Designation', @om.region_area.designation

    assert_equal "(555) 555-5555", @om.phone
    assert_equal "(555) 888-8888", @om.fax
    assert_equal "http://openmenu.com/", @om.website
    assert_equal "http://openmenu.com/menu/sample", @om.url

    logo = @om.logos.first
    assert_equal 'http://openmenu.com/images/ico-32-openmenu.png', logo.url
    assert_equal 'Thumbnail', logo.type
    assert_equal 'All', logo.media
    assert_equal 32, logo.height
    assert_equal 32, logo.width

    # environment
    assert_equal 96, @om.seating_quantity
    assert_equal 12, @om.max_group_size
    assert_equal '0', @om.smoking_allowed
    assert_equal '1', @om.takeout_available
    assert_equal '1', @om.delivery_available
    assert_equal 6.5, @om.delivery.radius
    assert_equal 12.00, @om.delivery.fee
    assert_equal '1', @om.catering_available
    assert_equal 'Suggested', @om.reservations
    assert_equal 'Reservation Online', @om.online_reservations.first.name
    assert_equal 'http://www.on-res.com', @om.online_reservations.first.url
    assert_equal 'web/mobile', @om.online_reservations.first.type
    assert_equal true, @om.online_reservations?
    assert_equal 'Order Online', @om.online_orders.first.name
    assert_equal 'http://www.on-order.com', @om.online_orders.first.url
    assert_equal 'web/mobile', @om.online_orders.first.type
    assert_equal true, @om.online_orders?
    assert_equal 'Live', @om.music_type
    assert_equal 'Full Bar', @om.alcohol_type
    assert_equal '0', @om.pets_allowed
    assert_equal '+55', @om.age_level_preference
    assert_equal '1', @om.wheelchair_accessible
    assert_equal 'casual', @om.dress_code
    assert_equal 'Steakhouse', @om.cuisine_type_primary
    assert_equal 'Seafood', @om.cuisine_type_secondary
    assert_equal 'street_free', @om.parking.street_free
    assert_equal 'street_metered', @om.parking.street_metered
    assert_equal 'private_lot', @om.parking.private_lot
    assert_equal 'garage', @om.parking.garage
    assert_equal 'valet', @om.parking.valet
    assert_equal 'outdoor', @om.seating_locations.first
    assert_equal 'USD', @om.accepted_currencies.first

    assert_equal 1, @om.operating_days.first.day_of_week
    assert_equal '11:00', @om.operating_days.first.open_time
    assert_equal '22:00', @om.operating_days.first.close_time
    assert_equal 7, @om.operating_days.size

    contact = @om.contacts.first
    assert_equal 'primary', contact.type
    assert_equal 'Chris', contact.first_name
    assert_equal 'Hanscom', contact.last_name
    assert_equal 'menu@openmenu.com', contact.email

    parent = @om.parent_company
    assert_equal 'Flintstones Global', parent.name
    assert_equal 'http://flintstones.com', parent.website
    assert_equal '123 Main Street', parent.address_1
    assert_equal 'Suite 1', parent.address_2
    assert_equal 'Bedrock', parent.city
    assert_equal 'Bedrock', parent.town
    assert_equal 'WY', parent.state
    assert_equal 'WY', parent.province
    assert_equal '12345', parent.postal_code
    assert_equal 'USA', parent.country
    assert_equal '(111) 111-1111', parent.phone
    assert_equal '(111) 222-2222', parent.fax

    assert_equal 2, @om.menus.size
  end

  def test_menu_parse
    menus = OpenMenu::Menu.parse(sample_om)
    assert_equal 'Main Menu', menus.first.name
    assert_equal 25, menus.first.uid
    assert_equal 'USD', menus.first.currency
    assert_equal 'disabled', menus.first.disabled
    assert_equal true, menus.first.disabled?

    assert_equal 'lunch-dinner', menus.first.duration.name
    assert_equal '11:00', menus.first.duration.start
    assert_equal '22:00', menus.first.duration.end

    group = menus.first.groups.first
    assert_equal 'Appetizers', group.name
    assert_equal 2, group.uid
    assert_equal 'disabled', group.disabled
    assert_equal true, group.disabled?

    option = menus.first.groups[1].options.first
    assert_equal 'Dressings', option.name
    assert_equal 1, option.min_selected
    assert_equal 2, option.max_selected
    assert_equal "Yummy dressings", option.information

    option_item = option.items.first
    assert_equal 'Italian', option_item.name
    assert_equal 1.00, option_item.additional_cost

    item = group.items.first
    assert_equal 65, item.uid
    assert_equal 'disabled', item.disabled
    assert_equal true, item.disabled?
    assert_equal 'special', item.special
    assert_equal true, item.special?
    assert_equal 'vegetarian', item.vegetarian
    assert_equal true, item.vegetarian?
    assert_equal 'vegan', item.vegan
    assert_equal true, item.vegan?
    assert_equal 'kosher', item.kosher
    assert_equal true, item.kosher?
    assert_equal 'halal', item.halal
    assert_equal true, item.halal?
    assert_equal 'Coconut Shrimp', item.name
    assert_equal 'Menu Item Description', item.description
    assert_equal 7.95, item.price
    assert_equal 350, item.calories
    assert_equal nil, item.heat_index
    assert_equal 1, group.items[1].heat_index
    
    assert_equal 'Contains Seafood', item.allergy.information
    assert_equal 'seafood, coconut', item.allergy.allergens
    
    image = item.images.first
    assert_equal 'http://openmenu.com/images/coconut_shrimp.jpg', image.url
    assert_equal 32, image.width
    assert_equal 32, image.height
    assert_equal 'Thumbnail', image.type
    assert_equal 'Web', image.media

    option = item.options.first
    assert_equal 'Sauce', option.name
    assert_equal 1, option.min_selected
    assert_equal 2, option.max_selected
    assert_equal 'Saucy sauces', option.information

    option_item = option.items.first
    assert_equal 'Honey', option_item.name
    assert_equal 3.99, option_item.additional_cost

    tag = item.tags.first
    assert_equal 'prawns', tag 

    size = group.items[2].sizes.first
    assert_equal 'small', size.name
    assert_equal 'Description', size.description
    assert_equal 6.95, size.price
    assert_equal 3000, size.calories
  end

  def sample_om
    <<-XML
<omf uuid="sample" date_created="2011-08-19" accuracy="1">
<openmenu>
<version>1.5</version>
<cat>Black</cat>
<crosswalks>
<crosswalk>
<crosswalk_id>31b8bfbf-08a3-478f-a4a4-d3e3143a37fb</crosswalk_id>
<crosswalk_company>Factual</crosswalk_company>
<crosswalk_url>
http://factual.com/31b8bfbf-08a3-478f-a4a4-d3e3143a37fb
</crosswalk_url>
</crosswalk>
</crosswalks>
</openmenu>
<restaurant_info>
<restaurant_name>My Restaurant</restaurant_name>
<business_type>independent</business_type>
<brief_description>Brief Description</brief_description>
<full_description>Full Description</full_description>
<location_id>x123z</location_id>
<longitude>-81.039833</longitude>
<latitude>33.999458</latitude>
<utc_offset>-5.00</utc_offset>
<address_1>803 Gervais Street</address_1>
<address_2>STE 2</address_2>
<city_town>Columbia</city_town>
<state_province>SC</state_province>
<postal_code>29202</postal_code>
<country>US</country>
<region_area name="Region Name" designation="Region Designation"/>
<phone>(555) 555-5555</phone>
<fax>(555) 888-8888</fax>
<website_url>http://openmenu.com/</website_url>
<omf_file_url>http://openmenu.com/menu/sample</omf_file_url>
<logo_urls>
<logo_url type="Thumbnail" media="All" height="32" width="32">http://openmenu.com/images/ico-32-openmenu.png</logo_url>
<logo_url type="Full" media="All">http://openmenu.com/images/sample_logo_full.png</logo_url>
</logo_urls>
<environment>
<seating_qty>96</seating_qty>
<max_group_size>12</max_group_size>
<age_level_preference>+55</age_level_preference>
<smoking_allowed>0</smoking_allowed>
<takeout_available>1</takeout_available>
<delivery_available radius="6.5" fee="12.00">1</delivery_available>
<catering_available>1</catering_available>
<reservations>Suggested</reservations>
<alcohol_type>Full Bar</alcohol_type>
<music_type>Live</music_type>
<pets_allowed>0</pets_allowed>
<wheelchair_accessible>1</wheelchair_accessible>
<dress_code>casual</dress_code>
<cuisine_type_primary>Steakhouse</cuisine_type_primary>
<cuisine_type_secondary>Seafood</cuisine_type_secondary>
<seating_locations>
<seating_location>outdoor</seating_location>
<seating_location>indoor</seating_location>
</seating_locations>
<accepted_currencies>
<accepted_currency>USD</accepted_currency>
</accepted_currencies>
<online_reservations>
<online_reservation type="web/mobile">
<online_reservation_name>Reservation Online</online_reservation_name>
<online_reservation_url>http://www.on-res.com</online_reservation_url>
</online_reservation>
</online_reservations>
<online_ordering>
<online_order type="web/mobile">
<online_order_name>Order Online</online_order_name>
<online_order_url>http://www.on-order.com</online_order_url>
</online_order>
</online_ordering>
<operating_days>
<operating_day>
<day_of_week>1</day_of_week>
<open_time>11:00</open_time>
<close_time>22:00</close_time>
</operating_day>
<operating_day>
<day_of_week>2</day_of_week>
<open_time>11:00</open_time>
<close_time>22:00</close_time>
</operating_day>
<operating_day>
<day_of_week>3</day_of_week>
<open_time>11:00</open_time>
<close_time>22:00</close_time>
</operating_day>
<operating_day>
<day_of_week>4</day_of_week>
<open_time>11:00</open_time>
<close_time>22:00</close_time>
</operating_day>
<operating_day>
<day_of_week>5</day_of_week>
<open_time>11:00</open_time>
<close_time>22:00</close_time>
</operating_day>
<operating_day>
<day_of_week>6</day_of_week>
<open_time>11:00</open_time>
<close_time>22:00</close_time>
</operating_day>
<operating_day>
<day_of_week>7</day_of_week>
<open_time/>
<close_time/>
</operating_day>
</operating_days>
<parking street_free="street_free" street_metered="street_metered" private_lot="private_lot" garage="garage" valet="valet"/>
</environment>
<contacts>
<contact type="primary">
<first_name>Chris</first_name>
<last_name>Hanscom</last_name>
<email>menu@openmenu.com</email>
</contact>
</contacts>
<parent_company>
<parent_company_name>Flintstones Global</parent_company_name>
<parent_company_website>http://flintstones.com</parent_company_website>
<address_1>123 Main Street</address_1>
<address_2>Suite 1</address_2>
<city_town>Bedrock</city_town>
<state_province>WY</state_province>
<postal_code>12345</postal_code>
<country>USA</country>
<phone>(111) 111-1111</phone>
<fax>(111) 222-2222</fax>
</parent_company>
</restaurant_info>
<menus>
<menu name="Main Menu" currency_symbol="USD" uid="25" disabled="disabled">
<menu_description/>
<menu_duration>
<menu_duration_name>lunch-dinner</menu_duration_name>
<menu_duration_time_start>11:00</menu_duration_time_start>
<menu_duration_time_end>22:00</menu_duration_time_end>
</menu_duration>
<menu_groups>
<menu_group name="Appetizers" uid="2" disabled="disabled">
<menu_group_description/>
<menu_items>
<menu_item uid="65" disabled="disabled" special="special" vegetarian="vegetarian" vegan="vegan" kosher="kosher" halal="halal">
<menu_item_name>Coconut Shrimp</menu_item_name>
<menu_item_description>Menu Item Description</menu_item_description>
<menu_item_price>7.95</menu_item_price>
<menu_item_calories>350</menu_item_calories>
<menu_item_allergy_information allergens="seafood, coconut">Contains Seafood</menu_item_allergy_information>
<menu_item_image_urls>
<menu_item_image_url width="32" height="32" type="Thumbnail" media="Web">http://openmenu.com/images/coconut_shrimp.jpg</menu_item_image_url>
</menu_item_image_urls>
<menu_item_options>
<menu_item_option name="Sauce" min_selected="1" max_selected="2">
<menu_item_option_information>Saucy sauces</menu_item_option_information>
<menu_item_option_item>
<menu_item_option_name>Honey</menu_item_option_name>
<menu_item_option_additional_cost>3.99</menu_item_option_additional_cost>
</menu_item_option_item>
</menu_item_option>
</menu_item_options>
<menu_item_tags>
<menu_item_tag>prawns</menu_item_tag>
<menu_item_tag>seafood</menu_item_tag>
</menu_item_tags>
</menu_item>
<menu_item>
<menu_item_name>Tempura Onion Rings</menu_item_name>
<menu_item_description>With a honey Thai sauce</menu_item_description>
<menu_item_price>7.95</menu_item_price>
<menu_item_heat_index>1</menu_item_heat_index>
</menu_item>
<menu_item special="special">
<menu_item_name>Calamari</menu_item_name>
<menu_item_description>
Our calamari is lightly fried and tossed with a sweet and spicy Asian mango sauce.
</menu_item_description>
<menu_item_price/>
<menu_item_heat_index>2</menu_item_heat_index>
<menu_item_sizes>
<menu_item_size>
<menu_item_size_name>small</menu_item_size_name>
<menu_item_size_description>Description</menu_item_size_description>
<menu_item_size_price>6.95</menu_item_size_price>
<menu_item_size_calories>3000</menu_item_size_calories>
</menu_item_size>
<menu_item_size>
<menu_item_size_name>large</menu_item_size_name>
<menu_item_size_description/>
<menu_item_size_price>8.95</menu_item_size_price>
</menu_item_size>
</menu_item_sizes>
</menu_item>
</menu_items>
</menu_group>
<menu_group name="Salads" uid="3">
<menu_group_description/>
<menu_group_options>
<menu_group_option name="Dressings" min_selected="1" max_selected="2">
<menu_group_option_information>Yummy dressings</menu_group_option_information>
<menu_group_option_item>
<menu_group_option_name>Italian</menu_group_option_name>
<menu_group_option_additional_cost>1.00</menu_group_option_additional_cost>
</menu_group_option_item>
<menu_group_option_item>
<menu_group_option_name>French</menu_group_option_name>
<menu_group_option_additional_cost>1.25</menu_group_option_additional_cost>
</menu_group_option_item>
<menu_group_option_item>
<menu_group_option_name>Thousand Island</menu_group_option_name>
<menu_group_option_additional_cost>1.00</menu_group_option_additional_cost>
</menu_group_option_item>
</menu_group_option>
</menu_group_options>
<menu_items>
<menu_item>
<menu_item_name>Chef Salad</menu_item_name>
<menu_item_description>Best chef salad in a 20 mile radius</menu_item_description>
<menu_item_price/>
<menu_item_sizes>
<menu_item_size>
<menu_item_size_name>half</menu_item_size_name>
<menu_item_size_description/>
<menu_item_size_price>6.95</menu_item_size_price>
</menu_item_size>
<menu_item_size>
<menu_item_size_name>full</menu_item_size_name>
<menu_item_size_description/>
<menu_item_size_price>8.95</menu_item_size_price>
</menu_item_size>
</menu_item_sizes>
</menu_item>
<menu_item special="special">
<menu_item_name>Cobb Salad</menu_item_name>
<menu_item_description>
Iceberg lettuce topped with turkey, ham, hard cooked eggs, avocado, diced tomatoes, bacon, bleu cheese crumbles and black olives
</menu_item_description>
<menu_item_price/>
<menu_item_sizes>
<menu_item_size>
<menu_item_size_name>half</menu_item_size_name>
<menu_item_size_description/>
<menu_item_size_price>6.95</menu_item_size_price>
</menu_item_size>
<menu_item_size>
<menu_item_size_name>full</menu_item_size_name>
<menu_item_size_description/>
<menu_item_size_price>8.95</menu_item_size_price>
</menu_item_size>
</menu_item_sizes>
</menu_item>
<menu_item>
<menu_item_name>Ceasar Salad</menu_item_name>
<menu_item_description>Fresh romain lettuce with aged parmesan reggiano</menu_item_description>
<menu_item_price>9.95</menu_item_price>
</menu_item>
<menu_item vegetarian="vegetarian">
<menu_item_name>Garden Salad</menu_item_name>
<menu_item_description>
Filled with lettuce, tomatoes, carrots, radishes, cucumbers and shredded cheese
</menu_item_description>
<menu_item_price>8.95</menu_item_price>
</menu_item>
</menu_items>
</menu_group>
<menu_group name="Entrees" uid="1">
<menu_group_description/>
<menu_items>
<menu_item uid="1">
<menu_item_name>Rack of Lamb</menu_item_name>
<menu_item_description>Coffee Citrus Crusted Lamb</menu_item_description>
<menu_item_price>22.95</menu_item_price>
</menu_item>
<menu_item uid="2">
<menu_item_name>Soft Shell Crabs</menu_item_name>
<menu_item_description>
Almond encrusted, seasoned and sauteed in butter to a crispy brown
</menu_item_description>
<menu_item_price>19.95</menu_item_price>
<menu_item_allergy_information allergens="shellfish, nuts">Reference allergens for allergy information</menu_item_allergy_information>
</menu_item>
<menu_item uid="3" special="special">
<menu_item_name>Cioppino</menu_item_name>
<menu_item_description>
Fresh fish, scallops, mussels, calamari, and shrimp in a tomato-garlic saffron broth over linguini
</menu_item_description>
<menu_item_price>24.95</menu_item_price>
</menu_item>
</menu_items>
</menu_group>
</menu_groups>
</menu>
<menu name="Late Night Menu" currency_symbol="USD" uid="35">
<menu_description/>
<menu_duration>
<menu_duration_name>late-night</menu_duration_name>
<menu_duration_time_start>20:00</menu_duration_time_start>
<menu_duration_time_end>23:00</menu_duration_time_end>
</menu_duration>
<menu_groups>
<menu_group name="Bar Food" uid="1">
<menu_group_description/>
<menu_items>
<menu_item>
<menu_item_name>Cheese Sticks</menu_item_name>
<menu_item_description>Cheese sticks with marinara sauce</menu_item_description>
<menu_item_price>6.95</menu_item_price>
</menu_item>
<menu_item>
<menu_item_name>Coconut Shrimp</menu_item_name>
<menu_item_description>Crispy Coconut Shrimp</menu_item_description>
<menu_item_price>7.95</menu_item_price>
<menu_item_calories>350</menu_item_calories>
</menu_item>
<menu_item>
<menu_item_name>Tempura Onion Rings</menu_item_name>
<menu_item_description>With a honey Thai sauce</menu_item_description>
<menu_item_price>7.95</menu_item_price>
</menu_item>
<menu_item>
<menu_item_name>Calamari</menu_item_name>
<menu_item_description>
Our calamari is lightly fried and tossed with a sweet and spicy Asian mango sauce.
</menu_item_description>
<menu_item_price>8.85</menu_item_price>
</menu_item>
</menu_items>
</menu_group>
</menu_groups>
</menu>
</menus>
</omf>
    XML
  end
  def example_om
    <<-XML
<omf uuid="1111-2222" date_created="2011-08-19" accuracy="500">
  <openmenu>
    <version>1.5</version>
    <crosswalks>
      <crosswalk>
        <crosswalk_id>Crosswalk ID</crosswalk_id>
        <crosswalk_company>Crosswalk Company</crosswalk_company>
        <crosswalk_url>Crosswalk URL</crosswalk_url>
      </crosswalk>
    </crosswalks>
  </openmenu>

  <restaurant_info>
    <restaurant_name>Restaurant Name</restaurant_name>
    <brief_description>Brief Description</brief_description>
    <full_description>Full Description</full_description>
    <business_type>independent</business_type>
    <location_id>x123z</location_id>
    <logo_urls>
      <logo_url width="Width" height="Height" type="Type" media="Media">Logo URL</logo_url>
    </logo_urls>
    <address_1>Address 1</address_1>
    <address_2>Address 2</address_2>
    <city_town>City Town</city_town>
    <region_area name="Name" designation="Designation"/>
    <state_province>State Providence</state_province>
    <postal_code>Postal Code</postal_code>
    <country>Country</country>
    <phone>Phone</phone>
    <fax>Fax</fax>
    <longitude>-81.039833</longitude>
    <latitude>33.999458</latitude>
    <utc_offset>UTC Offset</utc_offset>
    <website_url>Website URL</website_url>
    <omf_file_url>OMF URL</omf_file_url>
    <environment>
      <seating_qty>Seating QTY</seating_qty>
      <smoking_allowed></smoking_allowed>
      <max_group_size></max_group_size>
      <pets_allowed></pets_allowed>
      <age_level_preference></age_level_preference>
      <dress_code></dress_code>
      <cuisine_type_primary></cuisine_type_primary>
      <cuisine_type_secondary></cuisine_type_secondary>
      <takeout_available></takeout_available>
      <delivery_available radius="" fee=""></delivery_available>
      <catering_available></catering_available>
      <wheelchair_accessible></wheelchair_accessible>
      <reservations></reservations>
      <alcohol_type></alcohol_type>
      <music_type></music_type>
      <parking street_free="" street_metered="" private_lot="" garage="" valet=""></parking>
      <seating_locations>
        <seating_location></seating_location>
      </seating_locations>
      <accepted_currencies>
        <accepted_currency></accepted_currency>
      </accepted_currencies>
      <online_reservations>
        <online_reservation type="">
          <online_reservation_name></online_reservation_name>
          <online_reservation_url></online_reservation_url>
        </online_reservation>
      </online_reservations>
      <online_ordering>
        <online_order type="">
          <online_order_name></online_order_name>
          <online_order_url></online_order_url>
        </online_order>
      </online_ordering>
      <operating_days>
        <operating_day>
          <day_of_week></day_of_week>
          <open_time></open_time>
          <close_time></close_time>
        </operating_day>
      </operating_days>
    </environment>
    <parent_company>
      <parent_company_name></parent_company_name>
      <parent_company_website></parent_company_website>
      <address_1></address_1>
      <address_2></address_2>
      <city_town></city_town>
      <state_province></state_province>
      <postal_code></postal_code>
      <country></country>
      <phone></phone>
      <fax></fax>
    </parent_company>
    <contacts>
      <contact type="">
        <first_name></first_name>
        <last_name></last_name>
        <email></email>
      </contact>
    </contacts>
  </restaurant_info>

  <menus>
    <menu name="Menu Name" uid="UID" currency_symbol="Currency" disabled="">
      <menu_description>Description</menu_description>
      <menu_duration>
        <menu_duration_name>Duration Name</menu_duration_name>
        <menu_duration_time_start>Start</menu_duration_time_start>
        <menu_duration_time_end>End</menu_duration_time_end>
      </menu_duration>
      <menu_groups>
        <menu_group name="Group Name" uid="UID" disabled="">
      	<menu_group_description>Description</menu_group_description>
          <menu_group_options>
            <menu_group_option name="Group Option Name" min_selected="Min" max_selected="Max">
               <menu_group_option_information>Group Option Information</menu_group_option_information>
               <menu_group_option_item>
                 <menu_group_option_name>Option Item Name</menu_group_option_name>
                 <menu_group_option_additional_cost>Option Item Cost</menu_group_option_additional_cost>
               </menu_group_option_item>
               <menu_group_option_item>
                 <menu_group_option_name>Option Item Name 2</menu_group_option_name>
                 <menu_group_option_additional_cost>Option Item Cost 2</menu_group_option_additional_cost>
               </menu_group_option_item>
            </menu_group_option>
          </menu_group_options>
          <menu_items>
            <menu_item uid="UID" disabled="" special="Special" vegetarian="Vegetarian" vegan="Vegan" kosher="Kosher" halal="Halal">
              <menu_item_name>Menu Item Name</menu_item_name>
              <menu_item_description>Menu Item Description</menu_item_description>
              <menu_item_image_urls>
                <menu_item_image_url width="Width" height="Height" type="Type" media="Media">Menu Item Image URL</menu_item_image_url>
              </menu_item_image_urls>
              <menu_item_price>Price</menu_item_price>
              <menu_item_calories>Calories</menu_item_calories>
              <menu_item_heat_index>Heat Index</menu_item_heat_index>
              <menu_item_allergy_information allergens="cat, duck">Don't eat this if you hate cats.</menu_item_allergy_information>
              <menu_item_sizes>
                <menu_item_size>
                  <menu_item_size_name>Small</menu_item_size_name>
                  <menu_item_size_description>Smallest</menu_item_size_description>
                  <menu_item_size_price>10.00</menu_item_size_price>
                  <menu_item_size_calories>10000</menu_item_size_calories>
                </menu_item_size>
                <menu_item_size>
                  <menu_item_size_name>Large</menu_item_size_name>
                  <menu_item_size_description>Largest</menu_item_size_description>
                  <menu_item_size_price>20.00</menu_item_size_price>
                  <menu_item_size_calories>20000</menu_item_size_calories>
                </menu_item_size>
              </menu_item_sizes>
              <menu_item_options>
                <menu_item_option name="Menu Item Option Name" min_selected="Min" max_selected="Max">
                  <menu_item_option_information>Item Option Information</menu_item_option_information>
                  <menu_item_option_item>
                    <menu_item_option_name>Item Option Name</menu_item_option_name>
                    <menu_item_option_additional_cost>Item Additonal Cost</menu_item_option_additional_cost>
                  </menu_item_option_item>
                </menu_item_option>
              </menu_item_options>
              <menu_item_tags>
                <menu_item_tag>Item Tag</menu_item_tag>
              </menu_item_tags>
            </menu_item>
          </menu_items>
        </menu_group>
      </menu_groups>
    </menu>
    <menu name="Menu Name" uid="UID" currency_symbol="Currency" disabled="disabled">
      <menu_duration>
        <menu_duration_name>Duration Name</menu_duration_name>
        <menu_duration_time_start>Start</menu_duration_time_start>
        <menu_duration_time_end>End</menu_duration_time_end>
      </menu_duration>
    </menu>
  </menus>
</omf>
    XML
  end
end
