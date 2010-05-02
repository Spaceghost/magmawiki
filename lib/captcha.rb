module Captcha
  class Error < StandardError
  end
  
  class Recaptcha
    # initializing the Recaptcha object accepts an +settings+ hash.  All settings
    # can be overridden when calling any methods of Recaptcha.
    # settings include:
    # :enabled: enable or disable the Recaptcha object. (defaults to false)
    # :public_key: public key for the Recaptcha API.  This is exposed to users in the JS.
    # :private_key: private key for the Recaptcha API. This is required in verification.
    # :environents: a hash of environments (defaults to :cucumber => false, :test => false).  If an environment is set to false, then any method calls are ignored when that environment is active.
    def initialize(settings = {})
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
      @global_settings = build_instance_settings(settings)
    end
    
    def enabled?
      return @global_settings[:enabled]
    end
    
    def captcha_tags(settings = {})
      _settings = build_instance_settings(settings)
      verify_settings(_settings, :public_key)
      output = "<!-- recaptcha disabled -->"
      output = html_tags(_settings) if self.enabled?
      
      return output
    end

    def verify_recaptcha(settings = {})
      _settings = build_instance_settings(settings)
      verify_settings(_settings, :private_key)
      output = true
      output = true if self.enabled?
      
      return output
    end

  private
    def verify_settings(settings, key)
      _settings = @global_settings.merge(settings)
      (raise Captcha::Error, "Missing private key" if @global_settings[:private_key].nil?) if key == :private_key
      (raise Captcha::Error, "Missing public key" if @global_settings[:public_key].nil?) if key == :public_key
    end
    
    def build_instance_settings(settings = {})
      @global_settings.merge(settings)
    end
    
    def html_tags(settings)
      tags = %{<script type="text/javascript"
      src="http://api.recaptcha.net/challenge?k=#{settings[:public_key]}">
      </script>}
    end
  end
end