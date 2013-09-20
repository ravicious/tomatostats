require 'spec_helper'

describe ClockworkTomatoImporter do
  let(:file) { "#{Rails.root}/spec/support/clockwork_tomato.csv" }
  let(:invalid_file) { "#{Rails.root}/spec/support/clockwork_tomato_invalid.csv" }

  it_behaves_like "an importer"
end
