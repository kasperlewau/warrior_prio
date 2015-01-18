module Helpers
  class << self
    def parse_json(file_path)
      JSON[File.read(file_path)].inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    end
  end
end