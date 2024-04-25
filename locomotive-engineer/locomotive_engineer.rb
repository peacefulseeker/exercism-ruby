class LocomotiveEngineer
  def self.generate_list_of_wagons(*args) # splat operator for unpacking the array
    args
  end

  def self.fix_list_of_wagons(each_wagons_id_, missing_wagons_a)
    first, second, third, *rest_a = each_wagons_id_
    [third] + missing_wagons_a + rest_a + [first, second]
  end

  def self.add_missing_stops(route, **stops)
    {**route, stops: stops.values}
  end

  def self.extend_route_information(route, more_route_information)
    {**route, **more_route_information }
  end
end
