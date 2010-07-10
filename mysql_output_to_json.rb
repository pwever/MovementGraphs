#!/usr/bin/ruby

def translateFile(f)
  infile = File.new(f,"r")
  lines = []
  while (line = infile.gets)
    unless (line.strip()[0..0]=="#") 
      values = line.strip.split(/\s+/)
      lines.push "{label:'',val:%i,lat:%.2f,lng:%.2f}" % values
    end
  end
  outfile = File.new("%s.json" % File.basename(f), "w")
  outfile.puts "celltowers = ["
  outfile.puts lines.join(",\n")
  outfile.puts "]"
  infile.close
  outfile.close
end

def printHelp
  puts "
  # Translate a mysql file
  # tower_count lat lng
  # into json
  # towers = [{val:tower_count, lat:lat, lng:lng}, {val:tower_count, lat:lat, lng:lng}]
  # Usage: ruby script_name.rb SoureceFile.dat
  "
end


if $0 == __FILE__
  if $*.length>0
    if $*[0]=="-h" || $*[0]=="--help"
      printHelp
    else
      translateFile($*[0])
    end
  else
    printHelp
  end
end
