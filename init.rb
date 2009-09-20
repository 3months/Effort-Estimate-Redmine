require 'redmine'

require 'estimate_patch'

require 'dispatcher'
Dispatcher.to_prepare do
  Issue.send(:include, Estimate::IssuePatch) 
end


Redmine::Plugin.register :redmine_effort_estimate do
  name 'Effort to time patch'
  url 'http://redmine.org'
  author 'Breccan McLeod-Lundy'
  author_url 'http://3months.com'
  
  description 'Plugin to set the time estimate based on effort '
  version '0.1.0'
  requires_redmine :version_or_higher => '0.8.0'
end
