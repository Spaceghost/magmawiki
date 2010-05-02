require 'spec_helper'
describe Captcha::Recaptcha do # TODO: is there a better way to do this?
  it "should return enabled status" do
    recaptcha = Captcha::Recaptcha.new({:enabled => true})
    recaptcha.should be_enabled
    recaptcha = Captcha::Recaptcha.new({:enabled => false})
    recaptcha.should_not be_enabled
  end
  
  it "should raise a Captcha::Error with missing private key" do
    recaptcha = Captcha::Recaptcha.new({:public_key => "something"})
    lambda { recaptcha.verify_recaptcha }.should raise_error(Captcha::Error)
  end
  
  it "should raise a Captcha::Error with missing public key" do
    recaptcha = Captcha::Recaptcha.new(:private_key => "something")
    lambda { recaptcha.captcha_tags }.should raise_error(Captcha::Error)
  end
end
