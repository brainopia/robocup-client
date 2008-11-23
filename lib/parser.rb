module Parser
  private
  
  def parse(raw_sexp)
    result, keys, values = {}, [], [[]]
    last_atom, new_list = '', false

    raw_sexp.each_byte do |byte|
      char = byte.chr
      
      case char
      when '('
        new_list = true
      when ' '
        if new_list
          keys << last_atom.to_sym
          values << []
          new_list = false
          last_atom = ''
        else
          unless last_atom == ''
            values.last << typified(last_atom)
            last_atom = ''
          end
        end
      when ')'
        unless last_atom == ''
          values.last << typified(last_atom)
          last_atom = ''
        end

        key, arguments = keys.pop, values.pop
        
        if arguments.size == 1
          arguments = arguments.first 
        elsif arguments.first.is_a? Hash
          arguments = arguments.inject({}) {|h,i| h.merge i }
          name = arguments.delete(:n)
          arguments = { name => arguments } if name
        end

        hash = { key => arguments }
        values.last << hash
        if keys.size == 0
          current_hash = keys.inject(result) {|h,k| h[k]||={} }
          if current_hash[key] && arguments.is_a?(Hash)
            current_hash[key].merge! arguments
          else
            current_hash[key] = arguments
          end
        end
      else
        last_atom << char
      end
    end
    result
  end

  def typified(atom)
    atom =~ /^[-+]?\d/ ? atom.to_f : atom.to_sym
  end
end