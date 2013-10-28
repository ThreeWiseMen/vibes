require 'spec_helper'

describe Vote do
  it { should validate_presence_of(:idea) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:kind) }
end
