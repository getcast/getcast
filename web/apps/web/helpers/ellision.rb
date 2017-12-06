module Web
  module Helpers
    module Ellision
      def ellide(string, n=50)
	      if string.size > n
	        string = string[0,n]
	        string[n-3,3] = "..."
	      end
	      string
      end
    end
  end
end