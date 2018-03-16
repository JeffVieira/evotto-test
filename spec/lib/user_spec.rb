require 'spec_helper'
require 'user'
require 'csv'
require 'pry'

RSpec.describe User, type: :model do

  let(:users) { [User.new(["jeff", 1, 1, 1]),
                  User.new(["ruby", 1, 1, 1])] }

  describe ".search" do

    before { users }
    after { User.class_variable_set(:@@users, []) }

    context "when query equal nil" do
      it "User should receive print once" do
         expect(User).to receive(:print).exactly(1).times
         User.search([nil])
      end
    end


    context "when query equal --find" do
      it "should return a object" do
        expect(User.find(["jeff"])).to eq([users.first])
      end

      it "should return empty array" do
        expect(User.find(["nome"])).to eq([])
      end

      it "User should receive find once" do
         expect(User).to receive(:find).exactly(1).times
         User.search(['--find'])
      end
    end

    context "when query equal --order_by" do
      it "should return a ordered array by name desc" do
        expect(User.sort("name", "desc")).to eq(users)
      end

      it "should return a ordered array by name asc" do
        expect(User.sort("name", "asc")).to eq(users.reverse)
      end

      it "User should receive order_by once" do
         expect(User).to receive(:sort).exactly(1).times
         User.search(['--order_by', 'name', 'desc'])
      end
    end

    context "when query equal --total" do
      it "User should receive sum once" do
         expect(User).to receive(:sum).exactly(1).times
         User.search(['--total', 'age'])
      end

      it "should puts total age" do
        expect(STDOUT).to receive(:puts).with('age: 2')
        User.sum("age")
        require_relative 'user_spec.rb'
      end

      it "should puts total projectCount" do
        expect(STDOUT).to receive(:puts).with('projectCount: 2')
        User.sum("projectCount")
        require_relative 'user_spec.rb'
      end

      it "should puts total totalValue" do
        expect(STDOUT).to receive(:puts).with('totalValue: 2')
        User.sum("totalValue")
        require_relative 'user_spec.rb'
      end

      it "should puts a message" do
        expect(STDOUT).to receive(:puts).with('Coluna name não pode ser somada')
        User.sum("name")
        require_relative 'user_spec.rb'
      end
    end

    context "when query not valid" do
      it "should return a object" do
        expect(STDOUT).to receive(:puts).with('comando --any não existe')
        User.search(["--any"])
        require_relative 'user_spec.rb'
      end
    end
  end

  describe ".import_from_file" do
    context "when file is a CSV" do
      it "should import user from file" do
        expect(User).to receive(:new).exactly(50).times
        User.import_from_file("data/users.csv")
      end
    end

    context "when file doesn't exist" do
      it "should puts Arquivo test.csv não encontrado" do
        expect(STDOUT).to receive(:puts).with('Arquivo test.csv não encontrado')
        User.import_from_file("test.csv")
        require_relative 'user_spec.rb'
      end
    end

    context "when file isn't a CSV" do
      it "should puts Arquivo deve ser um .csv" do
        expect(STDOUT).to receive(:puts).with('Arquivo deve ser um .csv')
        User.import_from_file("test.txt")
        require_relative 'user_spec.rb'
      end
    end
  end
end
