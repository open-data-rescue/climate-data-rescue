# Be sure to restart your server when you modify this file.

# DataRescueAtHome::Application.config.session_store :cookie_store,
#                                                    key: '_draw_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")

#
# Better practice to store session in cookie, using DB strore can
# and up with colllisions on page with ajax requests
#
Rails.application.config.session_store :cookie_store,
                                       key: '_draw_session'

# DataRescueAtHome::Application.config.session_store :active_record_store,
#                                                    key: '_draw_session'
