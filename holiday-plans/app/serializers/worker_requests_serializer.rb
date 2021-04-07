class WorkerRequestsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :requests
  set_id {nil}
end
