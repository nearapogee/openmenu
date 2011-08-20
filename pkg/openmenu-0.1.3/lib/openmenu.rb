require 'nokogiri'

module Openmenu
  VERSION = '0.1.3'

  def self.parse(xml)
    result = {}
    doc = Nokogiri::XML(xml) do |config|
      config.strict  
    end
    
    menus = Array.new
    doc.xpath('//menu').each do |menu|
      unless menu['disabled'] =~/disabled/i
        _menu = Hash.new

        # Duration
        duration = Hash.new
        _menu[:duration] = duration
        %w(name time_start time_end).each do |tag|
          text = menu.at_xpath(".//menu_duration_#{tag}").text
          duration[tag.to_sym] = text if text && text.length > 0
        end
        
        groups = Array.new
        menu.xpath('./menu_groups//menu_group').each do |group|
          unless group['disabled'] =~ /disabled/i
            _group = Hash.new
            %w(name uid).each do |attr|
              _group[attr.to_sym] = group[attr] if group[attr] && group[attr].length > 0
            end

            # Group Options
            group_options = Array.new
            group.xpath('./menu_group_options//menu_group_option').each do |option|
              _option = Hash.new
              %w(name min_selected max_selected).each do |attr|
                _option[attr.to_sym] = option[attr] if option[attr] && option[attr].length > 0
              end
              %w(information).each do |tag|
                text = option.xpath("./menu_group_option_#{tag}").text
                _option[tag.to_sym] = text if text && text.length > 0
              end

              # Group Option Items
              option_items = Array.new
              option.xpath('./menu_group_option_item').each do |item|
                _option_item = Hash.new
                %w(name additional_cost).each do |tag|
                  text = item.xpath("./menu_group_option_#{tag}").text
                  _option_item[tag.to_sym] = text if text && text.length > 0
                end
                option_items << _option_item
              end
              _option[:options] = option_items
              
              group_options << _option
            end
            
            # Items
            items = Array.new
            group.xpath('./menu_items//menu_item').each do |item|
              unless item['disabled'] =~ /disabled/i
                _item = Hash.new
                %w(uid).each do |attr|
                  _item[attr.to_sym] = item[attr] if item[attr] && item[attr].length > 0
                end
                %w(special vegetarian vegan kosher halal).each do |attr|
                  _item[attr.to_sym] = true if item[attr] =~ Regexp.new("#{attr}", Regexp::IGNORECASE)
                end
                %w(name description price heat_index calories).each do |tag|
                  text = item.xpath("./menu_item_#{tag}").text
                  _item[tag.to_sym] = text if text && text.length > 0
                end

                # Item Sizes
                sizes = Array.new
                item.xpath('./menu_item_sizes//menu_item_size').each do |size|
                  _size = Hash.new
                  %w(name description price calories).each do |tag|
                    text = size.xpath("./menu_item_size_#{tag}").text
                    _size[tag.to_sym] = text if text && text.length > 0
                  end
                  sizes << _size
                end
                _item[:sizes] = sizes if sizes.length > 0

                # Item Options
                item_options = Array.new
                item.xpath('./menu_item_options//menu_item_option').each do |option|
                  _option = Hash.new
                  %w(name min_selected max_selected).each do |attr|
                    _option[attr.to_sym]= option[attr] if option[attr] && option[attr].length > 0
                  end
                  %w(information).each do |tag|
                    text = option.xpath("./menu_item_option_#{tag}").text
                    _option[tag.to_sym] = text if text && text.length > 0
                  end

                  # Options
                  option_items = Array.new
                  option.xpath('./menu_item_option_item').each do |option_item|
                    _option_item = Hash.new
                    %w(name additional_cost).each do |tag|
                      text = option_item.xpath("./menu_item_option_#{tag}").text
                      _option_item[tag.to_sym] = text if text && text.length > 0
                    end
                    option_items << _option_item
                  end

                  _option[:options] = option_items
                  item_options << _option
                end
                _item[:options] = item_options if item_options.length > 0

                # Images
                images = Array.new
                item.xpath('./menu_item_image_urls//menu_item_image_url').each do |image|
                  _image = Hash.new
                  %w(width height type media).each do |attr|
                    _image[attr.to_sym] = image[attr] if image[attr] && image[attr].length > 0
                  end
                  _image[:url] = image.text if image.text && image.text.length > 0
                  images << _image
                end
                _item[:images] = images if images.length > 0

                # Tags
                tags = Array.new
                item.xpath('./menu_item_tags//menu_item_tag').each do |tag|
                  tags << tag.text if tag.text && tag.text.length > 0
                end
                _item[:tags] = tags if tags.length > 0

                items << _item
              end
            end

            _group[:items] = items if items.length > 0
            _group[:options] = group_options if group_options.length > 0
            groups << _group
          end
        end
        _menu[:groups] = groups if groups.length > 0
        
        # Menu
        %w(name uid currency_symbol).each do |attr|
          _menu[attr.to_sym] = menu[attr] if menu[attr] && menu[attr].length > 0
        end
        %w(description).each do |tag|
          text = menu.xpath('./menu_description').text
          _menu[tag] = text if text && text.length > 0
        end
        
        menus << _menu
      end
      result[:menus] = menus
    end
    result
  end
end
