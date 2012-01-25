class OpenMenu
  VERSION = '0.1.6'
  include HappyMapper
  tag 'omf'

  attribute :uuid, String
  attribute :date_created, String
  attribute :accuracy, Integer
  attribute :private, String

  # Public: Test if this OpenMenu is private
  #
  # Returns true if private.
  def private?
    private == 'private'
  end

  element :version, Float, :deep => true

  element :restaurant_name, String, :deep => true
  element :brief_description, String, :deep => true
  element :full_description, String, :deep => true
  element :business_type, String, :deep => true
  element :location_id, String, :deep => true
  element :mobile, Integer, :deep => true
  element :longitude, String, :deep => true
  element :latitude, String, :deep => true
  element :utc_offset, Float, :deep => true
  element :address_1, String, :deep => true
  element :address_2, String, :deep => true
  element :city, String, :tag => 'city_town', :deep => true
  alias_method :town, :city
  element :state, String, :tag => 'state_province', :deep => true
  alias_method :province, :state
  element :postal_code, String, :deep => true
  element :country, String, :deep => true

  class RegionArea
    include HappyMapper

    attribute :name, String
    attribute :designation, String
  end
  element :region_area, RegionArea

  element :phone, String, :deep => true
  element :fax, String, :deep => true
  element :website, String, :tag => 'website_url', :deep => true
  element :url, String, :tag => 'omf_file_url', :deep => true

  class Logo
    include HappyMapper
    tag 'logo_url'

    attribute :type, String
    attribute :media, String
    attribute :height, Integer
    attribute :width, Integer

    text_node :url, String
  end
  has_many :logos, Logo, :xpath => '//logo_urls'
  
  # environment
  element :seating_quantity, Integer, :tag => 'seating_qty', :deep => true
  element :max_group_size, Integer, :deep => true
  element :smoking_allowed, String, :deep => true
  element :takeout_available, String, :deep => true
  element :delivery_available, String, :deep => true
  
  class Delivery
    include HappyMapper
    tag 'delivery_available'

    attribute :radius, Float
    attribute :fee, Float
  end
  has_one :delivery, Delivery

  element :catering_available, String, :deep => true
  element :reservations, String, :deep => true
  element :music_type, String, :deep => true
  element :alcohol_type, String, :deep => true
  element :pets_allowed, String, :deep => true
  element :age_level_preference, String, :deep => true
  element :wheelchair_accessible, String, :deep => true
  element :dress_code, String, :deep => true
  element :cuisine_type_primary, String, :deep => true
  element :cuisine_type_secondary, String, :deep => true
  has_many :seating_locations, String, :tag => 'seating_location', :deep => true
  has_many :accepted_currencies, String, :tag => 'accepted_currency', :deep => true

  class Contact
    include HappyMapper
    tag 'contact'

    attribute :type, String

    element :first_name, String
    element :last_name, String
    element :email, String
  end
  has_many :contacts, Contact, :xpath => '//contacts'

  class ParentCompany
    include HappyMapper
    tag 'parent_company'

    element :name, String, :tag => 'parent_company_name'
    element :website, String, :tag => 'parent_company_website'
    element :address_1, String
    element :address_2, String
    element :city, String, :tag => 'city_town'
    alias_method :town, :city
    element :state, String, :tag => 'state_province'
    alias_method :province, :state
    element :postal_code, String
    element :country, String
    element :phone, String
    element :fax, String
  end
  has_one :parent_company, ParentCompany

  class OperatingDay
    include HappyMapper
    tag 'operating_day'

    element :day_of_week, Integer
    element :open_time, String
    element :close_time, String
  end
  has_many :operating_days, OperatingDay, :xpath => '//operating_days'

  class Parking
    include HappyMapper
    tag 'parking'

    %w(street_free street_metered private_lot garage valet).each do |type|
      attribute type.to_s, String
    end
  end
  element :parking, Parking
  
  class OnlineReservation
    include HappyMapper
    tag 'online_reservation'

    attribute :type, String

    element :name, String, :tag => 'online_reservation_name'
    element :url, String, :tag => 'online_reservation_url'
  end
  has_many :online_reservations, OnlineReservation, :xpath => '//online_reservations'
  def online_reservations?
    online_reservations.size > 0
  end

  class OnlineOrder
    include HappyMapper
    tag 'online_order'

    attribute :type, String

    element :name, String, :tag => 'online_order_name'
    element :url, String, :tag => 'online_order_url'
  end
  has_many :online_orders, OnlineOrder, :xpath => '//online_ordering'
  def online_orders?
    online_orders.size > 0
  end

  class Crosswalk
    include HappyMapper
    tag 'crosswalk'

    element :id, String, :tag => 'crosswalk_id'
    element :company, String, :tag => 'crosswalk_company'
    element :url, String, :tag => 'crosswalk_url'
  end
  has_many :crosswalks, OpenMenu::Crosswalk, :xpath => './crosswalks'

  class Menu
    include HappyMapper
    tag 'menu'
    
    attribute :name, String
    attribute :uid, Integer
    attribute :currency, String, :tag => 'currency_symbol'
    attribute :language, String
    attribute :disabled, String 
    def disabled?
      disabled == 'disabled'
    end

    element :description, String, :tag => "menu_description"
    element :note, String, :tag => "menu_note"

    class Duration
      include HappyMapper
      tag 'menu_duration'

      element :name, String, :tag => 'menu_duration_name'
      element :start, String, :tag => 'menu_duration_time_start'
      element :end, String, :tag => 'menu_duration_time_end'
    end
    has_one :duration, Duration
      
    class Group
      include HappyMapper
      tag 'menu_group'

      attribute :name, String
      attribute :uid, Integer
      attribute :disabled, String
      def disabled?
        disabled == 'disabled'
      end

      element :description, String, :tag => 'menu_group_description'
      element :note, String, :tag => "menu_group_note"

      class Option
        include HappyMapper
        tag 'menu_group_option'

        attribute :name, String
        attribute :min_selected, Integer
        attribute :max_selected, Integer

        element :information, String, :tag => 'menu_group_option_information'

        class Item
          include HappyMapper
          tag 'menu_group_option_item'

          element :name, String, :tag => 'menu_group_option_name'
          element :additional_cost, Float, :tag => 'menu_group_option_additional_cost'
        end
        has_many :items, Item

      end # OpenMenu::Menu::Group::Option
      has_many :options, Option

      class Item
        include HappyMapper
        tag 'menu_item'

        attribute :uid, Integer
        %w(disabled special vegetarian vegan kosher halal).each do |attr|
          attribute attr.to_s, String
          define_method("#{attr}?".to_s) { self.send(attr) == attr }
        end

        element :name, String, :tag => 'menu_item_name'
        element :description, String, :tag => 'menu_item_description'
        element :price, Float, :tag => 'menu_item_price'
        element :calories, Integer, :tag => 'menu_item_calories'
        element :heat_index, Integer, :tag => 'menu_item_heat_index'

        class Allergy
          include HappyMapper
          tag 'menu_item_allergy_information'

          attribute :allergens, String
          text_node :information, String
        end # OpenMenu::Menu::Group::Item::Allergy
        has_one :allergy, Allergy

        class Image
          include HappyMapper
          tag 'menu_item_image_url'

          attribute :width, Integer
          attribute :height, Integer
          attribute :type, String
          attribute :media, String

          text_node :url, String
        end # OpenMenu::Menu::Group::Item::Image
        has_many :images, Image

        class Size
          include HappyMapper
          tag 'menu_item_size'

          element :name, String, :tag => 'menu_item_size_name'
          element :description, String, :tag => 'menu_item_size_description'
          element :price, Float, :tag => 'menu_item_size_price'
          element :calories, Integer, :tag => 'menu_item_size_calories'
        end
        has_many :sizes, Size

        class Option
          include HappyMapper
          tag 'menu_item_option'

          attribute :name, String
          attribute :min_selected, Integer
          attribute :max_selected, Integer

          element :information, String, :tag => 'menu_item_option_information'

          class Item
            include HappyMapper
            tag 'menu_item_option_item'

            element :name, String, :tag => 'menu_item_option_name'
            element :additional_cost, Float, :tag => 'menu_item_option_additional_cost'
          end # OpenMenu::Menu::Group::Item::Option::Item
          has_many :items, Item

        end # OpenMenu::Menu::Group::Item::Option
        has_many :options, Option

        has_many :tags, String, :tag => 'menu_item_tag', :deep => true

      end # OpenMenu::Menu::Group::Item
      has_many :items, Item

    end # OpenMenu::Menu::Group
    has_many :groups, Group

  end # OpenMenu::Menu
  has_many :menus, Menu, :xpath => '//menus'

end # OpenMenu
