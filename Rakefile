# encoding: UTF-8

task :db do
  require "net/http/persistent"

  http = Net::HTTP::Persistent.new

  %w[A B C D E F G H J K L M N P Q R S T U V W X Y Z].each do |provincia|
    res = http.request(URI.parse("http://www.correoargentino.com.ar/consultas/cpa/obtener_localidades/#{provincia}")).body

    File.open("db/#{provincia}", "w") do |file|
      res.scan(/option value=.(\d+).+>(.+?)</) do |id, name|
        file.write(id)
        file.write(" ")
        file.write(name.gsub("&Ntilde;", "Ñ"))
        file.write("\n")
      end
    end
  end
end
