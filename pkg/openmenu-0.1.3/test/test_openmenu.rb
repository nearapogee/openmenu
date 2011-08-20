require "test/unit"
require "openmenu"

class TestOpenmenu < Test::Unit::TestCase
  def test_parse
    result = Openmenu.parse(sample_om)
    #puts result.inspect
    assert_kind_of Hash, result
    assert_kind_of Array, result[:menus]
    assert_equal 1, result[:menus].length
    assert_kind_of Hash, result[:menus].first
    assert_kind_of Hash, result[:menus].first[:duration]
    assert_kind_of Hash, result[:menus].first[:groups].first
    assert_kind_of Array, result[:menus].first[:groups].first[:options]
    assert_kind_of Hash, result[:menus].first[:groups].first[:options].first
    assert_kind_of Array, result[:menus].first[:groups].first[:items]
    assert_kind_of Hash, result[:menus].first[:groups].first[:items].first
    assert_kind_of Array, result[:menus].first[:groups].first[:items].first[:sizes]
    assert_kind_of Hash, result[:menus].first[:groups].first[:items].first[:sizes].first
    assert_kind_of Array, result[:menus].first[:groups].first[:items].first[:options]
    assert_kind_of Hash, result[:menus].first[:groups].first[:items].first[:options].first
    assert_kind_of Array, result[:menus].first[:groups].first[:items].first[:tags]
    assert_kind_of String, result[:menus].first[:groups].first[:items].first[:tags].first
    assert_kind_of Array, result[:menus].first[:groups].first[:items].first[:images]
    assert_kind_of Hash, result[:menus].first[:groups].first[:items].first[:images].first
  end

  def sample_om
    <<-XML
<omf uuid="OMF UUID" created_date="Created Date" accuracy="Accuracy">
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
    <full_description>Full Description.</full_description>
    <business_type>Business Type</business_type>
    <location_id>Location ID</location_id>
    <logo_urls>
      <logo_url width="Width" height="Height" type="Type" media="Media">Logo URL</logo_url>
    </logo_urls>
    <address_1>Address 1</address_1>
    <address_2>Address 2</address_2>
    <city_town>City Town</city_town>
    <region_area name="Name" designation="Designation">Region Area</region_area>
    <state_province>State Providence</state_province>
    <postal_code>Postal Code</postal_code>
    <country>Country</country>
    <phone>Phone</phone>
    <fax>Fax</fax>
    <longitude>Longitude</longitude>
    <latitude>Latitude</latitude>
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
