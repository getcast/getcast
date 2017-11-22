module Web::Controllers::Mosaic
  class Download
    include Web::Action

    def call(params)
      self.body = 'OK'
    end
  end
end
