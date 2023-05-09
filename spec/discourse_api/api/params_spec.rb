# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::Params do
  def params_for(h)
    DiscourseApi::API::Params.new(h).required(:r1).optional(:o1, :o2).default(d1: "default")
  end

  it "should raise on missing required params" do
    expect { params_for({ o1: "test" }).to_h }.to raise_error(ArgumentError)
  end

  it "should not raise when a required param is false" do
    expect { params_for({ r1: false }).to_h }.not_to raise_error
  end

  it "should not include optional params when not provided" do
    expect(params_for({ r1: "test" }).to_h).not_to include(:o1)
  end

  it "should include optional params if provided but blank" do
    expect(params_for({ r1: "test", o2: nil }).to_h).to include(:o2)
  end

  it "should include default params when defined but not provided" do
    expect(params_for({ r1: "test" }).to_h).to include(d1: "default")
  end

  it "should include default params when defined and provided" do
    expect(params_for({ r1: "test", d1: "override" }).to_h).to include(d1: "override")
  end

  it "should include optional and default params when defined and provided" do
    expect(params_for({ r1: "test", o1: "optional", d1: "override" }).to_h).to include(
      o1: "optional",
      d1: "override",
    )
  end
end
