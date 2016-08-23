require 'math_engine'

module MathComparison

  module Expression
    def self.eql?(exp_a, exp_b, options = {})
      begin
        #variables = options[:variables] ? options[:variables] : []
        variables = self.exp_variables(exp_a)
        variables_with_values = self.generate_values(variables)

        #p variables
        #p variables_with_values
        #puts "exp_a #{exp_a}"
        #puts "exp_b #{exp_b}"

        a = self.evaluate(exp_a.to_s, variables_with_values)
        b = self.evaluate(exp_b.to_s, variables_with_values)

        #puts "a: #{a}"
        #puts "b: #{b}"

        #precission of 6 decimal digits precision
        precision = options[:precision] || 6
        precision = 1.0 / (10 ** precision)

        diff = (a - b).abs
        return  diff < precision
      rescue => e
        puts "Error: #{e}"
        return false
      end
    end

    def self.eql_with_eql_sinal?(exp_a, exp_b, options = {})
      left_exp_a, right_exp_a = exp_a.split('=')
      left_exp_b, right_exp_b = exp_b.split('=')

      return ( self.eql?(left_exp_a, left_exp_b, options) &&
               self.eql?(right_exp_a, right_exp_b, options) ) ||
             ( self.eql?(left_exp_a, right_exp_b, options) &&
               self.eql?(right_exp_a, left_exp_b, options) )
    end

    def self.eql_with_many_answers?(exp_a, exp_b, options = {})
      exps_a = exp_a.split(';')
      exps_b = exp_b.split(';')
      return false if  exps_a.size != exps_b.size

      begin
        if options[:cmas_order]
          return self.cmas_order(exps_a, exps_b, options)
        else
          return self.not_cmas_order(exps_a, exps_b, options)
        end
      rescue => e
        puts "Error: #{e}"
        return false
      end
    end

    private
    def self.evaluate(exp, variables_with_values)
      engine = ::MathEngine.new
      variables_with_values.each do |key, value|
        engine.evaluate("#{key} = #{value}")
      end
      engine.evaluate(exp)
    end

    # Compare multiples answer not cosidering
    # its order
    def self.not_cmas_order(exps_a, exps_b, options)
      exps_a.each do |exp_a|
        equal = false
        exps_b.each do |exp_b|
          equal = self.eql?(exp_a, exp_b, options)
          break if equal
        end
        return false unless equal
      end
      return true
    end

    # Compare multiples answer cosidering
    # the order defined
    def self.cmas_order(exps_a, exps_b, options)
      exps_a.each_with_index do |el, index|
        equal = self.eql?(el, exps_b[index], options)
        return false unless equal
      end
      return true
    end

    def self.generate_values(variables)
      vwv = {}
      variables.each do |v|
        vwv[v] = rand()
      end
      vwv
    end

    def self.exp_variables(exp)
      exp.scan(/[a-z][a-z0-9_]*/).uniq
    end

  end

end
