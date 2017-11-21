require_relative 'framework/pooler'
require_relative 'foundfaces/lib/repositories/photos_repository'

src = {}
src[:tag] = "found faces"

rep = {}
r = PhotosRepository.new
rep.add(r)


pooler = Pooler(source: src, repositories:rep)
pooler.pool
