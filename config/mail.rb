require 'mail'

Mail.defaults do
  delivery_method :smtp, {
    :port => 3031 
  }
end