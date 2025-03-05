# # 
# # If an endpoint does not support the include parameter,
# # it MUST respond with 400 Bad Request to any requests that include it.
# #
# module ResourceMethods
#   extend ActiveSupport::Concern
#   include JSONAPI::Deserialization

#   def index
#     authorize model_class, policy_class: policy_class

#     meta = {}
#     meta[:total] = @collection_total if paginated
#     meta[:full_total] = @full_collection_total ? @full_collection_total : @collection_total if paginated
#     meta[:current_page] = @current_page if @current_page.present? && paginated
#     meta[:perPage] = @per_page if @per_page.present? && paginated
#     format = params[:format]

#     if format == 'xls' || format == 'xlsx'
#       if belongs_to_param_id
#         generate_xls(xls_serializer_class, { serializer: { model_id: belongs_to_param_id } })
#       else
#         generate_xls
#       end
#     else
#       if serializer_class
#         options = {
#           meta: meta,
#           include: filtered_serializer_includes(fields: fields), # need to adjust based omn field
#           params: {
#             domain: "#{request.base_url}",
#             current_person: current_person
#           }
#         }
#         options[:fields] = fields
#         # Example for sparse field set
#         # options[:fields] = {person: [:name, :email_addresses], email_address: [:email]}
#         render json: serializer_class.new(@collection,options).serializable_hash(),
#                content_type: 'application/json'
#       else
#         render json: @collection,
#                meta: meta,
#                root: 'data',
#                adapter: :json,
#                content_type: 'application/json'
#       end
#     end
#   end

#   def show
#     authorize @object, policy_class: policy_class
#     render_object(@object)
#   end

#   # creates a new instance but does not save it to the db
#   # Frontend could use this as a template
#   # endpoint like /person/new
#   def new
#     authorize @object, policy_class: policy_class
#     render_object(@object, includes: false)
#   end

#   def create
#     model_class.transaction do
#       authorize @object, policy_class: policy_class
#       before_save
#       @object.save!
#       after_save
#     end
#     after_save_tx
#     render_object(@object)
#   end

#   def update
#     changed = false
#     model_class.transaction do
#       if @object.new_record?
#         # authorize model_class, policy_class: policy_class
#         authorize @object, policy_class: policy_class
#         before_save
#         @object.save!
#         after_save
#       else
#         authorize @object, policy_class: policy_class
#         before_update
#         # updates does the save as well, need to assign without saving to determine if there is a change
#         @object.assign_attributes(strip_params(_permitted_params(model: object_name, instance: @object)))
#         # Then we can "save"
#         @object.save!
#         changed = @object.saved_changes?
#         # Rails.logger.debug("&****** has dirty #{@object.has_dirty_associations}")
#         @object.reload
#         after_update
#       end
#     end
#     ret = after_update_tx
#     return if ret
  
#     # also if relationships changed ....
#     if changed
#       render_object(@object)
#     else
#       render status: :no_content, json: {}.to_json, content_type: 'application/json'
#     end
#   end

#   def destroy
#     model_class.transaction do
#       authorize @object, policy_class: policy_class
#       @object.public_send(object_destroy_method)
#       render status: :ok, json: {}.to_json, content_type: 'application/json'
#     end
#   end

#   def restore
#     model_class.transaction do
#       authorize @object, policy_class: policy_class
#       @object.public_send(object_restore_method)
#       render_object(@object)
#     end
#   end

#   def render_object(object, serializer: nil, includes: true, jsonapi_included: nil)
#     serializer_used = serializer || serializer_class
#     jsonapi_included ||= serializer_includes
#     if serializer_used
#       options = {
#         include: filtered_serializer_includes(
#                    fields: fields,
#                    json_includes: jsonapi_included
#                  ),
#         params: {
#           domain: "#{request.base_url}",
#           current_person: current_person
#         }
#       }
#       options[:fields] = fields

#       render json: serializer_used.new(object, options).serializable_hash,
#              content_type: 'application/json'
#     else
#       render json: object,
#              content_type: 'application/json'
#     end
#   end

#   def before_update
#   end

#   def before_save
#   end

#   def after_update
#   end

#   def after_save
#   end

#   def after_save_tx
#   end

#   def after_update_tx
#   end

#   def object_destroy_method
#     :destroy
#   end

#   def object_restore_method
#   end

#   def action
#     params[:action].to_sym
#   end

#   def collection_params(do_paginate: true)
#     per_page = params[:perPage]&.to_i || model_class.default_per_page if paginated && do_paginate
#     per_page = nil unless paginated && do_paginate
#     current_page = params[:current_page]&.to_i || 1 if paginated && do_paginate
#     filters = if params[:filter]
#                 if params[:filter].kind_of? String
#                   JSON.parse(params[:filter]) 
#                 else
#                   params[:filter]
#                 end
#               end

#     return per_page, current_page, filters
#   end

#   def order_string(order_by: nil)
#     order_str = nil

#     order = order_by || params[:sortBy]
#     order ||= self.class::DEFAULT_SORTBY if defined? self.class::DEFAULT_SORTBY
#     order ||= ''

#     if !order.blank?
#       direction = params[:sortOrder]
#       direction ||= self.class::DEFAULT_ORDER if defined? self.class::DEFAULT_ORDER
#       direction ||= 'asc'

#       order_str = "#{order} #{direction}"
#       # Get null first or last from query
#       nulls_first = params[:nullsFirst]
#       # For PSQL NULLS FIRST is the default for DESC order, and NULLS LAST otherwise.
#       if nulls_first == 'true'
#         order_str += ' NULLS FIRST'
#       elsif nulls_first == 'false'
#         order_str += ' NULLS LAST'
#       else
#         if direction == 'asc'
#           order_str += ' NULLS FIRST'
#         else
#           order_str += ' NULLS LAST'
#         end
#       end
#     end

#     order_str
#   end

#   def collection_where
#     nil
#   end

#   def collection
#     base = if belong_to_class && belongs_to_param_id
#              parent = belong_to_class.find belongs_to_param_id
#              parent.send(belongs_to_relationship)
#            else
#              model_class
#            end

#     @per_page, @current_page, @filters = collection_params


#     q = if select_fields
#           select_fields
#         else
#           policy_scope(base, policy_scope_class: policy_scope_class)
#         end

#     if default_scope(query: q)
#       q = default_scope(query: q)
#     end

#     q = q.includes(includes)
#          .references(references)
#          .eager_load(eager_load)
#          .joins(join_tables)
#          .where(query(@filters))
#          .where(collection_where)
#         #  anpther where?

#     q = q.distinct if (join_tables && !join_tables.empty?) || make_distinct?

#     q = q.order(order_string)

#     # Rails.logger.debug "****************************"
#     # Rails.logger.debug "****************************"
#     # Rails.logger.debug "#{q.to_sql}"
#     # Rails.logger.debug "****************************"
#     # Rails.logger.debug "****************************"

#     if paginated
#       @full_collection_total = collection_total
#       instance_variable_set("@#{controller_name}", @full_collection_total)
#     end

#     if paginated
#       q.page(@current_page).per(@per_page)
#     else
#       q
#     end
#   end

#   def collection_total
#     base = if belong_to_class && belongs_to_param_id
#              parent = belong_to_class.find belongs_to_param_id
#              parent.send(belongs_to_relationship)
#            else
#              model_class
#            end

#     fq = policy_scope(base, policy_scope_class: policy_scope_class)
#     if default_scope(query: fq)
#       fq = default_scope(query: fq)
#     end      
#     fq.where(exclude_deleted_clause)
#       .includes(includes)
#       .references(references)
#       .eager_load(eager_load)
#       .joins(join_tables)
#       .distinct
#       .count
#   end

#   def query(filters = nil)
#     # Go through the filter and construct the where clause
#     deleted_clause = exclude_deleted_clause
#     return deleted_clause unless filters.present?

#     query = query_part(filter: filters)

#     return query unless deleted_clause

#     query ? query.and(deleted_clause) : deleted_clause
#   end

#   # if the element has a deleted_at we want the non deleted ones
#   def exclude_deleted_clause
#     return nil unless model_class.new.attributes.keys.include?('deleted_at')
#     table = Arel::Table.new(model_class.table_name)

#     table[:deleted_at].eq(nil)
#   end

#   def query_part(filter:)
#     q = nil
#     global_op = filter['op'] == 'all' ? :and : :or
#     filter['queries'].each do |query|
#       if query.is_a? Hash
#         part = query_part(filter: query)
#       else
#         key, operation, value = query

#         col_table = if (key.include?('responses.'))
#                       Arel::Table.new('survey_responses')
#         else
#           get_table(column: key)
#         end

#         if key == 'all'
#           # change to allowd limiting to named cols?, pass in list of cols to include based in what is displayed ...
#           model_class.columns.each do |col|
#             next unless [:text, :string].include?(col.type)
#             query_part = get_query_part(table: col_table, column: col.name, operation: 'like', value: value, key: key)
#             part = part ? part.or(query_part) : query_part
#           end
#           # This for survey submissions ....
#           if model_class == Survey::Submission
#             Survey::Response.columns.each do |col|
#               next unless [:text, :string].include?(col.type)
#               query_part = get_query_part(table: Arel::Table.new('survey_responses'), column: col.name, operation: 'like', value: value, key: key)
#               part = part ? part.or(query_part) : query_part
#             end
#           end
#         else
#           # Have a special key to allow for extra queries ...
#           if (key.include?('subquery'))
#             part = subquery(operation: operation, value: value)
#           else
#             col = if (key.include?('responses.'))
#                     'response_as_text'
#                   else
#                     get_column(column: key)
#                   end
#             if array_col?(col_name: col)
#               col_table = array_table(col_name: col)
#             end
#             if derived_col?(col_name: col)
#               col_table = derived_table(col_name: col)
#             end
#             part = get_query_part(table: col_table, column: col, operation: operation, value: value, top: true, key: key)

#             if (key.include?('responses.'))
#               key.slice! "responses."
#               part = part.and(col_table['question_id'].eq(key))
#             end
#           end
#         end
#       end

#       q = q ? q.send(global_op, part) : part if part
#     end

#     q
#   end

#   def get_table(column:)
#     col_table = Arel::Table.new(model_class.table_name)
#     col_table_name, col = column.split('.') if column.include? '.'

#     if col_table_name && model_class.reflections[col_table_name].class == ActiveRecord::Reflection::HasAndBelongsToManyReflection
#       # key = "#{model_class.reflections[col_table_name].join_table}.#{col}"
#       col_table = Arel::Table.new("#{model_class.reflections[col_table_name].join_table}")
#     elsif col_table_name && model_class.reflections[col_table_name].class == ActiveRecord::Reflection::HasManyReflection
#       # need to join with the people table
#       col_table = model_class.reflections[col_table_name].klass.arel_table #Arel::Table.new("#{col_table_name}")
#     elsif col_table_name && model_class.reflections[col_table_name].class == ActiveRecord::Reflection::BelongsToReflection
#       # need to join with the people table
#       col_table = model_class.reflections[col_table_name].klass.arel_table #Arel::Table.new("#{col_table_name}")
#     elsif col_table_name && model_class.reflections[col_table_name].class == ActiveRecord::Reflection::ThroughReflection
#       col_table = model_class.reflections[col_table_name].klass.arel_table
#     elsif col_table_name && col_table_name == 'tags'
#       col_table = ActsAsTaggableOn::Tag.arel_table #Arel::Table.new("#{ActsAsTaggableOn::Tag}")
#     end

#     return col_table
#   end

#   def get_column(column:)
#     col = column
#     col_table_name, col = column.split('.') if column.include? '.'

#     return col
#   end

#   def get_query_part(table:, column:, operation:, value:, top: false, key: nil)
#     op = translate_operator(operation: operation)

#     return nil if value.kind_of?(String) && value.blank?

#     if array_col?(col_name: column)
#       array_query = case operation.downcase
#                     when 'is'
#                       ::Arel.sql("('#{value.gsub("'","''")}' = ANY(#{table}.#{column}))")
#                     when 'is not'
#                       ::Arel.sql("('#{value.gsub("'","''")}' != ALL(#{table}.#{column}) or cardinality(#{table}.#{column}) = 0)")
#                     when 'is empty'
#                       ::Arel.sql("(cardinality(#{table}.#{column}) = 0)")
#                     when 'is not empty'
#                       ::Arel.sql("(cardinality(#{table}.#{column}) > 0)")
#                     when 'is only'
#                       ::Arel.sql("('#{value.gsub("'","''")}' = ALL(#{table}.#{column}) AND cardinality(#{table}.#{column}) != 0)")
#                     when 'is not only'
#                       ::Arel.sql("('#{value.gsub("'","''")}' = ANY(#{table}.#{column}) AND cardinality(#{table}.#{column}) > 1)")
#                     end

#       # This is crappy, but I do not see a way round it. If the first query part is a array literal one
#       # we can not AND or OR it with subsequent. So prefic with a dummy clause that will then pass along
#       # the ability to chain
#       if top
#         tbl = model_class.arel_table
#         dummy_query = tbl[:id].eq(tbl[:id])
#         return tbl[:id].eq(tbl[:id]).and(array_query)
#       else
#         return array_query
#       end
#     else
#       val = value
#       val = "%#{value}%" if op == :matches
#       val = "%#{value}%" if op == :does_not_match
#       val = "%#{value}" if operation == 'ends with'
#       val = "#{value}%" if operation == 'begins with'
#       val = nil if operation == 'is null'
#       val = nil if operation == 'is not null'
#       # empty and not empty need to take into account nulls as well
#       val = "''" if operation == 'is empty'
#       val = "''" if operation == 'is not empty'

#       if operation == 'is empty'
#         part = table[column.to_sym].send(op, val).or(
#           table[column.to_sym].send(op, nil)
#         )
#       elsif operation == 'is not empty'  # not_eq
#         part = table[column.to_sym].send(op, val).and(
#           table[column.to_sym].send(op, nil)
#         )
#       elsif operation == 'is not' # not_eq
#         # is not, need to ignore the others (TODO, how???)
#         part = table[column.to_sym].send(op, val).or(
#           # 'is not' needs to retutn the nulls as well
#           table[column.to_sym].send(:eq, nil)
#         )
#       else
#         part = table[column.to_sym].send(op, val)
#       end
#     end
#   end

#   # Convert the operation passed in via teh filter into
#   # an arel predicate op
#   # operators: ['equals','does not equal','contains','does not contain','is empty','is not empty','begins with','ends with'],
#   # operators: ['=','<>','<','<=','>','>='],
#   # TODO: test = "" and != "ssss" ('equals','does not equal') for string values
#   # operators: ['is','is not','is empty','is not empty'] - TEST
#   def translate_operator(operation:)
#     # Fix does not match, in (not in), is not empty etc
#     case operation.downcase
#     when 'does not contain'
#       :'does_not_match' # "%val%"
#     when 'contains'
#       # depend on type of the search
#       :'matches' # "%val%"
#     when 'like'
#       :'matches' # "%val%"
#     when 'in'
#       :in
#     when 'not in'
#       :not_in
#     when 'equals'
#       :eq
#     when 'equal'
#       :eq
#     when '='
#       :eq
#     when 'does not equal'
#       # does not return blanks or nulls
#       :not_eq
#     when '<>'
#       :not_eq
#     when '!='
#       :not_eq
#     when 'is less than'
#       :lt
#     when '<'
#       :lt
#     when 'is greater than'
#       :gt
#     when '>'
#       :gt
#     when 'is less than or equal to'
#       :lteq
#     when '<='
#       :lteq
#     when 'is greater than or equal to'
#       :gteq
#     when '>='
#       :gteq
#     when 'is'
#       :eq
#     when 'is not'
#       :not_eq
#     when 'is empty'
#       :eq
#     when 'is not empty'
#       :not_eq
#     when 'begins with'
#       :'matches'
#     when 'ends with'
#       :'matches'
#     when 'is null'
#       :eq
#     when 'is not null'
#       :not_eq
#     else
#       :eq
#     end
#     # does_not_match, #does_not_match_all, #does_not_match_any, #does_not_match_regexp,
#     # in, not_in etc
#   end

#   def subquery(operation:, value: nil)
#     nil
#   end

#   def select_fields
#     nil
#   end

#   def default_scope(query: nil)
#     nil
#   end

#   def model_name
#     "#{model_class}"
#   end

#   def model_class
#     if defined?(self.class::MODEL_CLASS)
#       self.class::MODEL_CLASS.constantize
#     else
#       self.class.name.sub('Controller', '').singularize.constantize
#     end
#   end

#   def serializer_class
#     self.class::SERIALIZER_CLASS.constantize if defined? self.class::SERIALIZER_CLASS
#   end

#   def generate_xls(serializer = nil, opts = {})
#     opts[:each_serializer] = serializer ? serializer : xls_serializer_class
#     opts[:serializer] = {} unless opts[:serializer]
#     opts[:serializer][:current_person] = current_person
#     cookies[:fileDownload] = true
#     fname = self.class::XLS_SERIALIZER_FILENAME if defined? self.class::XLS_SERIALIZER_FILENAME
#     fname ||= controller_name.downcase
#     # How do we pass the current person to the serializer?
#     send_data ActiveModel::XlsArraySerializer.new(
#       @collection,
#       opts
#     ).to_xls,
#     filename: "#{fname}_#{Time.now.strftime('%m-%d-%Y')}.xlsx",
#     disposition: 'attachment'
#   end

#   def xls_serializer_class
#     return self.class::XLS_SERIALIZER_CLASS.constantize if defined? self.class::XLS_SERIALIZER_CLASS

#     'ActiveModel::XlsSerializer'.constantize
#   end

#   # authorize @publication, policy_class: PublicationPolicy
#   def policy_class
#     # return an overide for policy class if there is one
#     return self.class::POLICY_CLASS.constantize if defined? self.class::POLICY_CLASS

#     # else use the 'global' policy
#     # TODO: global policy class

#     # if we return none then Pundit's policy finder will be used ...
#     return PlannerPolicy
#   end

#   def policy_scope_class
#     return self.class::POLICY_SCOPE_CLASS.constantize if defined? self.class::POLICY_SCOPE_CLASS

#     PlannerPolicy::Scope
#   end

#   def object_name
#     controller_name.singularize
#   end

#   def resource_id
#     params[:id]
#   end

#   def load_resource
#     if member_action?
#       @object ||= load_resource_instance

#       instance_variable_set("@#{object_name}", @object)
#     else
#       @collection ||= collection
#       @collection_total ||= collection.total_count if paginated
#       @collection_total ||= collection.size unless paginated

#       instance_variable_set("@#{controller_name}", @collection_total)
#       instance_variable_set("@#{controller_name}", @collection)
#     end
#   end

#   def load_resource_instance
#     if new_actions.include?(action)
#       build_resource
#     elsif resource_id
#       # JSON api could send a resource with UUID generated
#       # client side. If we do not find it in the DB we then
#       # will create it!
#       find_resource || build_resource
#     elsif update_actions.include?(action)
#       build_resource
#     end
#   end

#   def find_resource
#     if belongs_to_param_id && belong_to_class
#       parent = belong_to_class.find belongs_to_param_id

#       return nil unless policy_scope(
#         parent.send(belongs_to_relationship),
#         policy_scope_class: policy_scope_class
#       ).exists?(resource_id)

#       policy_scope(
#         parent.send(belongs_to_relationship),
#         policy_scope_class: policy_scope_class
#       ).find(resource_id)
#     else
#       return nil unless policy_scope(model_class, policy_scope_class: policy_scope_class).exists?(resource_id)

#       policy_scope(model_class, policy_scope_class: policy_scope_class).find(resource_id)
#     end
#   end

#   def build_resource
#     if belongs_to_param_id && belong_to_class
#       parent = belong_to_class.find belongs_to_param_id
#       parent.send(belongs_to_relationship).new(strip_params(_permitted_params(model: object_name)))
#     else
#       model_class.new(strip_params(_permitted_params(model: object_name)))
#     end
#   end

#   def collection_actions
#     [:index]
#   end

#   def member_action?
#     !collection_actions.include? action
#   end

#   def new_actions
#     [:new, :create]
#   end

#   def update_actions
#     [:update]
#   end

#   def allowed_params
#     nil
#   end

#   def except_params
#     nil
#   end

#   # TODO: optimize
#   def fields
#     _fields = params.permit(fields: {})[:fields].to_h
#     _fields.each do |k,v|
#       _fields[k] = v.split(',')
#     end

#     _fields
#   end

#   def add_to_serialized_includes(rels:)
#     serializer_includes = serializer_includes.concat(rels)
#   end

#   def filtered_serializer_includes(fields: , json_includes: nil)
#     includes = json_includes if json_includes
#     includes ||= serializer_includes
#     # p = params[:include].split(",")
#     includes.concat(params[:include].split(",")) if params[:include]
#     # Rails.logger.debug("******* INCLUDES #{includes} #{p}")
#     return includes if fields.empty?

#     keys = fields.flatten(2)
#     includes.select{|v| keys.include?(v.to_s)}
#   end

#   def serializer_includes
#     []
#   end

#   def includes
#     []
#   end

#   def references
#     []
#   end

#   def join_tables
#     []
#   end

#   def eager_load
#     []
#   end

#   def belongs_to_param_id
#     nil
#   end

#   def belong_to_class
#     nil
#   end

#   def belongs_to_relationship
#     nil
#   end

#   def paginate
#     true
#   end

#   def paginated
#     format = params[:format]
#     return false if format == 'xls' || format == 'xlsx'
#     return false unless paginate && !params[:perPage].nil?

#     params[:perPage]&.to_i
#   end

#   def derived_col?(col_name:)
#     false
#   end

#   def array_col?(col_name:)
#     false
#   end

#   def make_distinct?
#     false
#   end

#   def permitted_params()
#     _permitted_params(model: nil)
#   end

#   def _permitted_params(model: , instance: nil)
#     # NOTE: if params[:data] to determine if this is JSON-API packet
#     # that is received, if so we need to deserialize it
#     _allowed_params = if model && !allowed_params.blank?
#                         # need to subtract the params that are not allowed because of permissions
#                         allowed_params - AccessControlService.banned_attributes(model: model.capitalize, instance: instance, person: current_person)
#                       end
#     if params[:data]
#       # NOTE: JSPON API does not save nested data structures ....
#       jsonapi_deserialize(
#         params,
#         {
#           except: except_params,
#           # NOTE: allowed params need to include relationship name if there needed for save
#           only: _allowed_params
#         }
#       )
#     else
#       # We treat this as a regular rails request
#       return params.require(model).permit! unless _allowed_params || params[:action] == 'new'

#       params.permit(
#         _allowed_params
#       )
#     end
#   end

#   def strip_params(_params)
#     return unless _params

#     _params.each{|k,v| _params[k] = v&.strip if v.respond_to?(:strip)}
#   end
# end
