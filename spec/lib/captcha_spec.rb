require 'spec_helper'
require 'nokogiri'

describe Captcha::Recaptcha do # TODO: is there a better way to do this?
  it "should return enabled status" do
    recaptcha = Captcha::Recaptcha.new({:enabled => true, :captcha_provider => :recaptcha})
    recaptcha.should be_enabled
    recaptcha = Captcha::Recaptcha.new({:enabled => false, :captcha_provider => :recaptcha})
    recaptcha.should_not be_enabled
  end
  
  context "#verify_recaptcha" do
    it "#verify_recaptcha should raise a Captcha::Error with missing private key" do
      recaptcha = Captcha::Captcha.new({:private_key => nil})
      lambda { recaptcha.verify_recaptcha }.should raise_error(Captcha::CaptchaError)
    
      recaptcha = Captcha::Captcha.new(:private_key => "something")
      lambda { recaptcha.verify_recaptcha }.should_not raise_error(Captcha::CaptchaError)
    end
  end
  
  context "#captcha_tags" do
    it "should raise a Captcha::Error with missing public key" do
      recaptcha = Captcha::Captcha.new(:public_key => nil)
      lambda { recaptcha.captcha_tags }.should raise_error(Captcha::CaptchaError)
    
      recaptcha = Captcha::Captcha.new(:public_key => "something")
      lambda { recaptcha.captcha_tags }.should_not raise_error(Captcha::CaptchaError)
    end
    
    it "should return well formed html" do
      settings = Hash.new
      settings = { :enabled      => true,
                  :public_key   => "something",
                  :private_key  => "something"
                 }
      recaptcha = Captcha::Captcha.new(settings)
      recaptcha.should_not be_nil
      recaptcha.captcha_tags.should_not be_nil
      output = recaptcha.captcha_tags
      
      validated_output = Nokogiri::HTML output
      validated_output.errors.should be_empty
    end
  end
end
