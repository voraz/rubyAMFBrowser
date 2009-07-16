# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_teste_session',
  :secret      => '57b4900f3d66d52ef57c2fae957c4f8ce74cc6a7bdf55432e9eb5572500e47653a350bffa9f1b23af266c7fbad1d20f6cddf0616e083b0a8871f656346ecacce'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
