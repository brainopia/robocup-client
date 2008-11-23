module Parser
  private
  
  def parse(raw_sexp)
    result, keys, values = {}, [], [[]]
    last_atom, new_list = '', false

    raw_sexp.each_char do |char|
      case char
      when '('
        new_list = true
      when ' '
        if new_list
          keys << last_atom.to_sym
          values << []
          new_list = false
        else
          values.last << typed(last_atom) if last_atom != ''        
        end
        last_atom = ''
      when ')'
        if last_atom != ''
          values.last << typed(last_atom)
          last_atom = ''
        end
        value = values.pop
        if value.size == 1
          value = value.first 
        elsif value.first.is_a? Hash
          name = nil
          value.delete_if {|it| name = it[:n] if it[:n] }
          value = value.inject({}) {|h,i| h.merge i }
          value = { name => value } if name
        end
        hash = { keys.pop => value }
        values.last << hash
        current_hash = keys.inject(result) {|h,k| h[k] || (h[k] = {}) }
        if keys.size == 0
          if current_hash[hash.keys.first] && value.is_a?(Hash)
            current_hash[hash.keys.first].merge! value
          else
            current_hash[hash.keys.first] = value
          end
        end
      else
        last_atom << char
      end
    end
    result
  end

  def typed(atom)
    if atom =~ /^[-+]?(\d)+\.(\d)+$/
      atom.to_f
    else
      atom.to_sym
    end
  end
end