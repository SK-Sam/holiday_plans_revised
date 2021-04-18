class OverlappingRequestsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :overlaps
  set_id {nil}
end
