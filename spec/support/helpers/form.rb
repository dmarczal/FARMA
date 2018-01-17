module Helpers
  module Form
    def fill_in_form(form, fields, submit = '//button[type="submit"]')
      within(form) do
        fields.each do |field, val|
          fill_in field, with: val
        end
      end

      find(submit).click
    end
  end
end