module APIResponses
  extend ActiveSupport::Concern

  included do
    attr_accessor :data, :status_response, :data_type, :error
  end

  private

  def not_found_response
    self.status_response = :not_found

    render json: {status: status_response, error_type: data_type}, status: status_response
  end

  def bad_request_response
    render json: serialize_error, status: status_response
  end

  def json_response
    render json: serialize_data, status: status_response
  end

  def serialize_error
    {
      error_type: data_type,
      error: error,
      status: status_response
    }
  end

  def serialize_data
    {
      data_type: data_type,
      data: data,
      status: status_response
    }
  end

  def serializable_resource
    ActiveModelSerializers::SerializableResource
  end
end
