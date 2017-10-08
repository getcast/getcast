require 'hanami/mailer'

Hanami::Maler.configure do
  # Set the root path where to search for templates
  # Argument: String, Pathname, #to_pathname, defaults to the current directory
  #
  root '/path/to/root'

  # Set the default charset for emails
  # Argument: String, defaults to "UTF-8"
  #
  default_charset 'iso-8859'

  # Set the delivery method
  # Argument: Symbol
  # Argument: Hash, optional configurations
  delivery_method :stmp
