require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:about_me) }
  it { should have_many(:ideas) }
  it { should have_many(:votes) }
  it { should have_many(:comments) }
end
