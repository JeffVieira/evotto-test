require './lib/string'

class User
  @@users = []

  attr_accessor :name, :age, :project_count, :total_value

  def initialize(params)
    self.name = params[0]
    self.age = params[1].to_i
    self.project_count = params[2].to_i
    self.total_value = params[3].to_i

    @@users.to_a.push(self)
  end

  def self.import_from_file(file_path)
    if File.extname(file_path) != ".csv"
      puts "Arquivo deve ser um .csv"
      return false
    end

    unless File.exists?(file_path)
      puts "Arquivo #{file_path} não encontrado"
      return false
    end

    CSV.foreach(file_path, headers: true) do |row|
      User.new(row)
    end

    return true
  end

  def self.search(query)
    case query[0]
    when '--find'
      find(query[1..-1])
    when '--order_by'
      sort(query[1], query[2])
    when '--total'
      sum(query[1])
    when nil
      print(@@users)
    else
      puts "comando #{query[0]} não existe"
    end
  end

  private

  def self.find(params)
    sorted = []
    params.each do |param|
      @@users.find{|user| sorted.push(user) if user.name.downcase.include?(param.to_s.downcase) }
    end
    print(sorted)
    sorted
  end

  def self.sort(column, direction="desc")
    sorted = @@users.sort do |x,y|
      if direction == "desc"
        x.send(column) <=> y.send(column)
      else
        y.send(column) <=> x.send(column)
      end
    end
    print(sorted)
    sorted
  end

  def self.sum(column)
    if ['age', 'total_value', 'project_count'].include?(column.underscore)
      puts "#{column}: #{@@users.map(&column.underscore.to_sym).inject(:+)}"
    else
      puts "Coluna #{column} não pode ser somada"
    end
  end

  def self.print(array)
    if array.compact.empty?
      puts "Nenhum registro encontrado"
    else
      puts "Name | Age | ProjectCount | TotalValue"
      array.each do |user|
        puts "#{user.name} | #{user.age} | #{user.project_count} | #{user.total_value}"
      end
    end
  end
end
