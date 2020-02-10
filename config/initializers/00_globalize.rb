
# module Globalize
#   module ActiveRecord
#     module ActMacro
#       alias_method :old_check_columns!, :check_columns!
#       def check_columns!(attr_names)
#         return if ::ActiveRecord::VERSION::STRING >= "5.0" || ! connected?
#         old_check_columns!(attr_names)
#       end


#       alias_method :old_allow_translation_of_attributes, :allow_translation_of_attributes
#       def allow_translation_of_attributes(attr_names)
#         return if ::ActiveRecord::VERSION::STRING >= "5.0" || ! connected?
#         old_allow_translation_of_attributes!(attr_names)
#       end
#     end
#   end
# end
