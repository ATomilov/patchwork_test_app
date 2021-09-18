module ObjectFilterers
  module Hashes
    class SliceKeys < ::BaseServiceObject
      class << self
        def in_array_of_hashes(array:, keys: [])
          return array unless keys.present?

          array.map do |hash|
            hash.slice(*keys)
          end
        end
      end
    end
  end
end
