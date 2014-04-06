require 'spec_helper'

describe Notification do
  it { should belong_to(:event) }
  it { should belong_to(:subscription) }
  it { should validate_presence_of(:format) }
  it { should ensure_inclusion_of(:format).in_array(Notification::FORMATS) }
end
