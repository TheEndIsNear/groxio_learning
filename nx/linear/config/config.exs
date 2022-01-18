import Config

config :nx, :default_defn_options, compiler: EXLA

import_config "#{config_env()}.exs"
