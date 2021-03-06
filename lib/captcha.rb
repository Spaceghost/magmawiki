module Captcha  
  class Recaptcha
    def initialize(options = {})
      @global_settings = {
                          :enabled          => false,
                          :public_key       => nil,
                          :private_key      => nil,
                          :captcha_provider => :recaptcha,
                          :environments     => {
                            :cucumber         => false,
                            :test             => false,
                            },
                          }
      @global_settings = build_instance_options(options)
    end
    
    def enabled?
      return @global_settings[:enabled]
    end
    
    def recaptcha_tags(options = {})
      output = ""
      if self.enabled?
        options = build_instance_options(options)
        output = html_tags(options)
      end
      return output
    end

    def verify_recaptcha(options = {})
      if self.enabled?

      else
        return true
      end
    end

  private
    def build_instance_options(options = {})
      @global_settings.merge(options)
    end
    
    def html_tags(options)
      tags = %{<script type="text/javascript"
      src="http://api.recaptcha.net/challenge?k=#{options[:public_key]}">
      </script>}
    end
  end
end