describe Fastlane::Actions::LizardAction do
  describe '#run' do
    it 'prints out lizard output' do
      expected_command = "lizard | sed -n -e '/^$/,$p'"
      expect(Fastlane::Actions).to raise_error(ArgumentError)

      
    end
  end
end
