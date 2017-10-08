module Web::Controllers::Session
  class New
    include Web::Action

    def call(params)
      self.body = 'OK'
    end
  end
end
