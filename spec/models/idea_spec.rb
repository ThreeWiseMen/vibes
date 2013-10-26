require 'spec_helper'

describe Idea do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:leader) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:user) }
  it { should belong_to(:idea) }
end
