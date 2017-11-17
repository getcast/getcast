module Web::Controllers::Users
  class SubsAjax
    include Web::Action

    def call(params)
      self.body = 'OK'
    end
  end
end
