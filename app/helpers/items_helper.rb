module ItemsHelper
    def get_item_locations (items)
        locations = []
        items.each do |item|
            if !item.taken
                address = get_location(item.user_id) 
                if !address.nil?
                    address[:url] = item_url(item)
                    address[:description] = item.description
                    address.to_json 
                    if !user_signed_in?
                        locations.push(address)
                    #don't display current user's item on the map
                    elsif user_signed_in? && item.user_id != current_user.id
                        locations.push(address)
                    end
                end
            end
        end
        return locations.to_json
    end
end
