class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || I18n.t("invalid_url")) unless url_valid?(value)
  end

  # a URL may be technically well-formed but may
  # not actually be valid, so this checks for both.
  def url_valid?(url)
    begin
      uri = URI.parse(url)
      Net::HTTP.get_response(uri).code == '200'
    rescue
      false
    end
  end
end
