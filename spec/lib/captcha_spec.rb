require 'spec_helper'
describe Captcha::Recaptcha do # TODO: is there a better way to do this?
  it "should return enabled status" do
    recaptcha = Captcha::Recaptcha.new({:enabled => true})
    recaptcha.should be_enabled
    recaptcha = Captcha::Recaptcha.new({:enabled => false})
    recaptcha.should_not be_enabled
  end
  
  it "should raise an error with no private key" do
    recaptcha = Captcha::Recaptcha.new()
    lambda { recaptcha.captcha_tags }.should raise_error(Captcha::Error)
    
  end
end
