class ArgsValidator

  def self.args_valid?(args)
    if args[0] != "--source"
      puts "Primero parametro deve ser --source"
      return false
    end

    if args[1].nil?
      puts "Segundo parametro deve ser caminho do arquivo.csv"
      return false
    end

    return true
  end
end
