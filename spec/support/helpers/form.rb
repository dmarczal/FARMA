module Helpers
  module Form
    def fill_in_form(form, fields)
      within(form) do
        fields.each do |field, val|
          fill_in field, with: val
        end
      end

      find('//button[type="submit"]').click
    end
  end
end