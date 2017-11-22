require 'hanami/model'
require_relative 'framework/pooler'
require_relative 'foundfaces/lib/foundfaces/repositories/photos_repository'
require_relative 'framework/updater'

src = {}
src[:tag] = "found faces"

rep = {}
r = PhotosRepository.new
rep.add(r)

up = {}
u = Updater.new
up.add(u)

pooler = Pooler(source: src, repositories: rep, updaters: up)
pooler.pool
