#!/usr/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'uri'

# expects a efl ffi source file with comments containing a URL on a single line, alone
# will add any missing methods :D

FILE_NAME = ARGV.first

def rubyized_enum(text)
  # generally in the form 'enum _Ecore_Some_Enum'
  text.gsub("enum ", "").gsub(/_|\s/, "")
end

def contains?(text)
  `grep "#{text}" #{FILE_NAME}` != ""
end

def map_type(type)
  type.gsub!("\u00A0", "")

  case type
  when /\*/
    ':pointer'
  when 'int', 'void', 'double', 'char', 'long'
    ":#{type}"
  when 'unsigned int'
    ':uint'
  when 'unsigned short'
    ':ushort'
  else
    raise "Dunno about this type: '#{type}'" unless type =~ /_/
    rubyized_enum(type)
  end
end

File.open(FILE_NAME, 'r').each_line do |line|
  puts line
  next unless line =~ /^\s*#/

  uri = URI.extract(line).first
  next if uri.nil?

  has_written_line = false

  doc = Nokogiri::HTML(open(uri))

  doc.xpath("//table[@class='memname']").each do |definition|
    if definition.text =~ /^enum /
      rubyized = rubyized_enum(definition.text)
      next if contains?(rubyized)
      STDERR.puts "'#{definition.text} may need to be defined as '#{rubyized}'"
    else
      sig = definition.xpath("./tr/td[@class='memname']").text.split(/\s/)

      eapi = const = return_value = pointer = method_name = nil
      case sig.length
      when 3
         eapi, return_value, method_name = sig
      when 4
         eapi, const, return_value, method_name = sig
      when 5
         eapi, const, return_value, pointer, method_name = sig
      end

      param_types = definition.xpath("./tr/td[@class='paramtype']")

      if param_types.empty?  # likely a constant
        STDERR.puts "Found constant #{method_name}"
        next
      end

      params = param_types.collect {|p| "#{map_type(p.text)}" }

      if contains?("attach_function :#{method_name},")
        STDERR.puts "FOUND #{method_name}"
        next
      end 

      puts "" unless has_written_line
      puts "  attach_function :#{method_name}, [#{params.join(', ')}], #{pointer.nil? ? map_type(return_value) : ':pointer'}"
      has_written_line = true
    end
  end
end
