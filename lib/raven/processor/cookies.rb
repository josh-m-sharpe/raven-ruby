module Raven
  class Processor::Cookies < Processor
    def process(data)
      process_if_symbol_keys(data) if data[:request]
      process_if_string_keys(data) if data["request"]

      data
    end

    private

    def process_if_symbol_keys(data)
      data[:request][:cookies] = data[:request][:cookies].merge(data[:request][:cookies]) { |_key, _value| STRING_MASK } \
        if data[:request][:cookies]

      return unless data[:request][:headers] && data[:request][:headers]["Cookie"]
      data[:request][:headers]["Cookie"] = STRING_MASK
    end

    def process_if_string_keys(data)
      data["request"]["cookies"] = data["request"]["cookies"].merge(data["request"]["cookies"]) { |_key, _value| STRING_MASK } \
        if data["request"]["cookies"]

      return unless data["request"]["headers"] && data["request"]["headers"]["Cookie"]
      data["request"]["headers"]["Cookie"] = STRING_MASK
    end
  end
end
