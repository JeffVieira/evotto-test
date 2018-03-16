require 'spec_helper'
require 'args_validator'

RSpec.describe ArgsValidator, type: :model do

  describe ".args_valid?" do
    context "when args are invalid" do
      it "should import user from file" do
        expect(STDOUT).to receive(:puts).with('Primero parametro deve ser --source')
        ArgsValidator.args_valid?(['--invalid'])
        require_relative 'args_validator_spec.rb'
      end

      it "should import user from file" do
        expect(STDOUT).to receive(:puts).with('Segundo parametro deve ser caminho do arquivo.csv')
        ArgsValidator.args_valid?(['--source'])
        require_relative 'args_validator_spec.rb'
      end
    end

    context "when args are valid" do
      it "should puts Arquivo test.csv não encontrado" do
        expect(ArgsValidator.args_valid?(['--source', 'data/users.csv'])).to eq(true)
      end
    end
  end
end
