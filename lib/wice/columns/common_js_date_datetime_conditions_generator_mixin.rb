module Wice
  module Columns #:nodoc:
    module CommonJsDateDatetimeConditionsGeneratorMixin #:nodoc:

      def generate_conditions(table_alias, opts)   #:nodoc:

        # Is this a datetime based column?
        datetime = @column_wrapper.type == :datetime

        conditions = [[]]
        if opts[:fr]
          conditions[0] << " #{@column_wrapper.alias_or_table_name(table_alias)}.#{@column_wrapper.name} >= ? "
          date = if datetime
            opts[:fr].to_datetime
          else
            opts[:fr].to_date
          end
          conditions << date
        end

        if opts[:to]
          op = '<='
          if datetime
            date = (opts[:to] + 1.day).to_datetime
            op = '<'
          else
            date = opts[:to].to_date
          end
          conditions[0] << " #{@column_wrapper.alias_or_table_name(table_alias)}.#{@column_wrapper.name} #{op} ? "
          conditions << date
        end

        return false if conditions.size == 1

        conditions[0] = conditions[0].join(' and ')
        conditions
      end

    end
  end
end
