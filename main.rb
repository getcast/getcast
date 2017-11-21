require_relative 'framework/pooler'
require_relative 'foundfaces/lib/repositories/'

src = {}
src[:tag] = "found faces"

pooler = Pooler(source: {})
pooler.pool
