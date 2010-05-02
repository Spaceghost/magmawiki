module Captcha
  class Error < StandardError
  end
  
  class Recaptcha
    # initializing the Recaptcha object accepts an +options+ hash.  All options
    # can be overridden when calling any methods of Recaptcha.
    # Options include:
    # :enabled: enable or disable the Recaptcha object. (defaults to false)
    # :public_key: public key for the Recaptcha API.  This is exposed to users in the JS.
    # :private_key: private key for the Recaptcha API. This is required in verification.
    # :environents: a hash of environments (defaults to :cucumber => false, :test => false).  If an environment is set to false, then any method calls are ignored when that environment is active.
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
    
    def captcha_tags(options = {})
      options = verify_options(options)
      output = ""
      output = html_tags(options) if self.enabled?
      
      return output
    end

    def verify_recaptcha(options = {})
      options = verify_options(options)
      output = true
      output = true if self.enabled?
      
      return output
    end

  private
    def verify_options(options)
      _options = @global_settings.merge(options)
      raise Captcha::Error, "Missing private key" if @global_settings[:private_key].nil?
      raise Captcha::Error, "Missing public key" if @global_settings[:public_key].nil?
    end
    
    def build_instance_options(options)
      @global_settings.merge(options)
    end
    
    def html_tags(options)
      tags = %{<script type="text/javascript"
      src="http://api.recaptcha.net/challenge?k=#{options[:public_key]}">
      </script>}
    end
  end
end