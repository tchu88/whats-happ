require 'spec_helper'

describe Notification do
  it { should belong_to(:event) }
  it { should belong_to(:subscription) }
end
