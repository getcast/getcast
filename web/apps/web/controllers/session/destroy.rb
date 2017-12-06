module Web::Controllers::Session
  class Destroy
    include Web::Action

    def call(params)
      self.body = 'OK'
    end
  end
end
