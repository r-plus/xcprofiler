require 'spec_helper'
include Xcprofiler

describe JSONReporter do
  let(:profiler) do
    Profiler.by_product_name('MyApp', derived_data_root).tap do |profiler|
      profiler.reporters = [reporter]
    end
  end

  let(:derived_data_root) { File.absolute_path(File.join(__FILE__, '../../fixtures')) }

  context 'with output' do
    let(:dir) { Dir.mktmpdir }
    let(:output) { File.join(dir, 'result.json') }
    let(:reporter) { JSONReporter.new(output: output) }

    it 'exports json' do
      profiler.report!
      expect(File.exist?(output)).to be_truthy
    end

    after do
      FileUtils.remove_entry dir
    end
  end

  context 'without output path' do
    let(:reporter) { JSONReporter.new }

    it 'raises error' do
      expect {
        profiler.report!
      }.to raise_error(OutputPathIsNotSpecified)
    end
  end
end
