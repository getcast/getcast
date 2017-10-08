module Web::Controllers::Session
  class Failure
    include Web::Action

    def call(params)
      self.body = 'OK'
    end
  end
end
