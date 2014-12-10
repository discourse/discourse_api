require 'spec_helper'

describe DiscourseApi::API::Params do
  def params_for(h)
    DiscourseApi::API::Params.new(h).required(:r1).optional(:o1, :o2)
  end

  it "should raise on missing required params" do
    expect { params_for({o1: "test"}).to_h }.to raise_error(ArgumentError)
  end

  it "should not include optional params when not provided" do
    expect(params_for({r1: "test"}).to_h).not_to include(:o1)
  end

  it "should include optional params if provided but blank" do
    expect(params_for({r1: "test", o2: nil}).to_h).to include(:o2)
  end

end
