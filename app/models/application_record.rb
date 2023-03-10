# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    # Returns formatted enum value according to current locale
    #
    # @param enum_name [String, Symbol] the name of the model enum attribute.
    # @param enum_value [String, Symbol] possible value of the model enum attribute.
    # @return [String] formated enum value.
    def i18n_enum(enum_name, enum_value)
      locale_key = enum_name.to_s.pluralize
      I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{locale_key}.#{enum_value}")
    end
  end
end
