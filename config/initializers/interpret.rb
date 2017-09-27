
if (Object.const_get(:Interpret).is_a?(Class) rescue false)
  Interpret.configure do |config|
    # config.parent_controller = "planner_controller" # the base controller for the interpret tools
    # config.layout = "application"
    # Some other configuration options
    # config.registered_envs << :development
    # config.scope = "(:locale)"
    config.current_user = "current_user"
    # config.admin = "interpret_admin?" # Add interpret_admin? to user object to say whether they can admin the translations
    # Also have roles of Editor and Admin ...???
    # Interpret.live_edit = true
    config.registered_envs = [:development, :staging, :production]
  end
end
