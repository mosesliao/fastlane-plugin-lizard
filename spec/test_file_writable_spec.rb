## TODO:
# 1) set show_warnings to true, expect sh_control_output
# 2) set show_warnings to default, no output
describe Fastlane::Actions::LizardAction do
  describe 'write to non-existent folder' do
    it 'fails with user error' do
      expect do
        Fastlane::FastFile.new.parse("lane :test do
          lizard(
            source_folder: 'lib',
            export_type: 'xml',
            report_file: 'no-such-folder/lizard-report.xml')
        end").runner.execute(:test)
      end.to raise_error("Please ensure no-such-folder/lizard-report.xml is writable")
    end
  end
end
