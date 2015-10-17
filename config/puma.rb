environment ENV['RAILS_ENV']
threads *(ENV['PUMA_THREADS'] || '0,5').split(',')
workers ENV['PUMA_WORKERS'] || 1

preload_app!
