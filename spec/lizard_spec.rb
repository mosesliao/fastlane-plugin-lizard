describe Fastlane::Actions::LizardAction do
  describe 'Lizard' do
    let(:output_file) { "lizard.result.json" }
    let(:folder) { "assets" }
    let(:language) { "java" }
    let(:multiple_languages) { "  java, swift,objectivec" }
    let(:expected_multiple_language_options) { "-l java -l swift -l objectivec" }
    let(:ccn) { 10 }
    let(:length) { 800 }
    let(:working_threads) { 3 }

    context "default use case" do
      it "default language as swift" do
        result = Fastlane::FastFile.new.parse("lane :test do
          lizard
        end").runner.execute(:test)

        expect(result).to eq("lizard -l swift")
      end

      it 'custom executable default as swift' do
        result = Fastlane::FastFile.new.parse("lane :test do
          lizard(
            executable: 'lizard/lizard.py'
          )
        end").runner.execute(:test)

        expect(result).to eq("python lizard/lizard.py -l swift")
      end
    end

    context "when specify export_type as XML" do
      it "prints out XML as stdout" do
        result = Fastlane::FastFile.new.parse("lane :test do
          lizard(
            export_type: 'xml'
          )
        end").runner.execute(:test)

        expect(result).to eq("lizard -l swift --xml")
      end
    end

    context "when specify export_type as CSV" do
      it "prints out CSV as stdout" do
        result = Fastlane::FastFile.new.parse("lane :test do
          lizard(
            export_type: 'csv'
          )
        end").runner.execute(:test)

        expect(result).to eq("lizard -l swift --csv")
      end
    end

    context "when specify folder to scan" do
      it "states the source folder" do
        result = Fastlane::FastFile.new.parse("lane :test do
          lizard(
            source_folder: '#{folder}'
          )
        end").runner.execute(:test)

        expect(result).to eq("lizard #{folder} -l swift")
      end
    end

    context "when specify language to scan" do
      it "overrides swift default language" do
        result = Fastlane::FastFile.new.parse("lane :test do
          lizard(
            language: '#{language}'
          )
        end").runner.execute(:test)

        expect(result).to eq("lizard -l #{language}")
      end
    end

    context "when specify multiple languages to scan" do
      it "states all specified languages" do
        result = Fastlane::FastFile.new.parse("lane :test do
          lizard(
            language: '#{multiple_languages}'
          )
        end").runner.execute(:test)

        expect(result).to eq("lizard #{expected_multiple_language_options}")
      end
    end

    context "when specify code complexity number" do
      it "overrides default 15" do
        result = Fastlane::FastFile.new.parse("lane :test do
          lizard(
            ccn: #{ccn}
          )
        end").runner.execute(:test)

        expect(result).to eq("lizard -l swift -C #{ccn}")
      end
    end

    context "when specify maximum function length warning" do
      it "overrides default 1000" do
        result = Fastlane::FastFile.new.parse("lane :test do
          lizard(
            length: #{length}
          )
        end").runner.execute(:test)

        expect(result).to eq("lizard -l swift -L #{length}")
      end
    end

    context "when specify number of working threads" do
      it "overrides default single thread" do
        result = Fastlane::FastFile.new.parse("lane :test do
          lizard(
            working_threads: #{working_threads}
          )
        end").runner.execute(:test)

        expect(result).to eq("lizard -l swift -t #{working_threads}")
      end
    end

    context "the `ignore_exit_status` option" do
      context "by default" do
        it 'should raise if lizard completes with a non-zero exit status' do
          allow(FastlaneCore::UI).to receive(:important)
          expect(FastlaneCore::UI).to receive(:important).with(/If you want fastlane to continue anyway/)
          # This is simulating the exception raised if the return code is non-zero
          expect(Fastlane::Actions).to receive(:sh).and_raise("fake error")
          expect(FastlaneCore::UI).to receive(:user_error!).with(/Lizard finished with errors/).and_call_original

          expect do
            Fastlane::FastFile.new.parse("lane :test do
              lizard
            end").runner.execute(:test)
          end.to raise_error(/Lizard finished with errors/)
        end
      end

      context "when enabled" do
        it 'should not raise if lizard completes with a non-zero exit status' do
          allow(FastlaneCore::UI).to receive(:important)
          expect(FastlaneCore::UI).to receive(:important).with(/fastlane will continue/)
          # This is simulating the exception raised if the return code is non-zero
          expect(Fastlane::Actions).to receive(:sh).and_raise("fake error")
          expect(FastlaneCore::UI).to_not(receive(:user_error!))

          Fastlane::FastFile.new.parse("lane :test do
            lizard(ignore_exit_status: true)
          end").runner.execute(:test)
        end
      end

      context "when disabled" do
        it 'should raise if lizard completes with a non-zero exit status' do
          allow(FastlaneCore::UI).to receive(:important)
          expect(FastlaneCore::UI).to receive(:important).with(/If you want fastlane to continue anyway/)
          # This is simulating the exception raised if the return code is non-zero
          expect(Fastlane::Actions).to receive(:sh).and_raise("fake error")
          expect(FastlaneCore::UI).to receive(:user_error!).with(/Lizard finished with errors/).and_call_original

          expect do
            Fastlane::FastFile.new.parse("lane :test do
              lizard(ignore_exit_status: false)
            end").runner.execute(:test)
          end.to raise_error(/Lizard finished with errors/)
        end
      end
    end

    context "when specify report_file options" do
      it "adds redirect file to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          lizard(
            report_file: '#{output_file}'
          )
        end").runner.execute(:test)

        expect(result).to eq("lizard -l swift > #{output_file}")
      end
    end
  end
end
