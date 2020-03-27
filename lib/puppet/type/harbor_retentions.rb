# frozen_string_literal: true

Puppet::Type.newtype(:harbor_retentions_policy) do
  desc <<-DESC
  @summary Manage Harbor retention policies
  
  @example Creating a replication policy within Harbor
      harbor_replication_policy { 'example-retention':
        ensure           => 'present',
        policy           => {
            rules => [ 
              tag_selectors => [{ 
                decoration => "string", 
                pattern = "string", 
                kind => "string" 
              }],
            action => "string"
            trigger => {},
            scope => {},
        }
      }
  DESC
  
  ensurable
  
  newparam(:policy) do
    desc 'The Rentention Policy'
    newvalues(:push, :pull)
  end
end
  