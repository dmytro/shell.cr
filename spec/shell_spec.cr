require "./spec_helper"



Spec2.describe "Shell" do

  describe "#run" do
    subject { Shell.new("ls") }

    context "good command" do


      it "does not fail" do
        expect { subject.run }.not_to raise_error Exception
      end


      context "output" do
        before {subject.run}

        it "returns string" { expect(subject.run).to be_a String }
        it "stderr is empty" { expect(subject.stderr).to eq ""}
        it "stdout is not empty" { expect(subject.stdout).not_to eq "" }
      end
    end

    context "with errors" do

      context "when command not found" do

        subject { Shell.new("doesnotexist") }

        it "fails" do
          expect { subject.run }.to raise_error(Exception)
        end

      end
      # end

      context "when command returns an error" do
        subject { Shell.new("ls nonexistenfile")}
        it "fails" { expect { subject.run}.to raise_error Exception }
      end
      # it "stderr returns error message" { pending "todo" {} }
      # it "stdout is empty" { pending "todo" {} }


      context "when errors ignored" do


        subject { Shell.new(command, fail_on_error: false) }

        context "bad command" do
          let (command) { "nonexistecommand" }
          it "does not fail" {
            expect{subject.run}.not_to raise_error Exception
          }

          context "output" do
            before { subject.run }

            it "stderr not empty" { expect(subject.stderr).not_to eq "" }
            it "stderr contains error message" {
              expect(subject.stderr).to match(/command not found/)
            }
            it "stdout is empty" { expect(subject.stdout).to eq "" }

          end
        end

        context "bad argument" do
          let (command) { "ls nonexistfile" }

          it "does not fail" {
            expect{subject.run}.not_to raise_error Exception
          }
          context "output" do
            before { subject.run }

            it "stderr is not empty" { expect(subject.stderr).not_to eq "" }
            it "stdout is empty" { expect(subject.stdout).to eq "" }
            it "stderr contains error message" {
              expect(subject.stderr).to match(/No such file or directory/)
            }
          end
        end
      end
    end
  end
end
