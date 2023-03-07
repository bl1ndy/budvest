# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def i18n_enum(enum_name, enum_value)
      locale_key = enum_name.to_s.pluralize
      I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{locale_key}.#{enum_value}")
    end
  end
end
