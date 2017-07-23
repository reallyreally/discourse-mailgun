require 'rails_helper'

describe DiscourseMailgun do
  it "fails signature verification on an invalid input" do
    expect(DiscourseMailgun::Engine.verify_signature('timestamp', 'token', 'sig', 'key')).to eq(false)
  end

  it "succeeds with correct input" do
    token = "d36d8af15b9694f9077abc4bb1be5475d4e9953329c9c0085e"
    sig = "925a06d45995704642609e93ae5e526ded7a0e2413f4094e794851c06b2561d6"
    ts = "1500815643"
    key = "key-ba22e794c07d6aacc4b0c51a2a7f615d"

    expect(DiscourseMailgun::Engine.verify_signature(ts, token, sig, key)).to eq(true)
  end
end
