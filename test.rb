 class Messageclass
    def method_missing(method_name, *args, &block)
      puts "Someone called #{method_name} with <#{args.join(", ")}>"
    end
  end


m = Messageclass.new

p m.something 

p m.anotherthing("parm1")

p m.morethings(["parm1", "parm2"], 7895)