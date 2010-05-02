require 'net/http'
require 'forwardable'
module Captcha
  class CaptchaError < StandardError
  end
  
  class Captcha
    extend Forwardable
    
    def initialize(options = {})
      throw Captcha::CaptchaError if options[:captcha_provider].nil?
      
      @captcha = Captcha.const_get(options[:captcha_provider]).new(options)
    end
    
    def_delegator :@captcha, :enabled?
    def_delegator :@captcha, :captcha_tags
    def_delegator :@captcha, :verify_captcha
  end
  
  class Base
  end
end