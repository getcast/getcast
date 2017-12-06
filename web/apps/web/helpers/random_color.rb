module Web
  module Helpers
    module RandomColor
     	@@colors = ['#136F63', '#C63955', '#D68E00', '#3E2F5B'] 
    	@@index = Random.rand(@@colors.size)
      def random_color
        @@index = (@@index + 1) % @@colors.size
        @@colors[@@index]
      end
    end
  end
end