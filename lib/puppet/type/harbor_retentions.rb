# frozen_string_literal: true

Puppet::Type.newtype(:harbor_retentions_policy) do
    desc <<-DESC
  @summary Manage Harbor retention policies
  
  @example Creating a replication policy within Harbor
      harbor_replication_policy { 'example-replication':
        ensure           => 'present',
        deletion         => false,
        enabled          => true,
        override         => false,
        policy           => {
            rules => [ tag_selectors   => [{ decoration => "string", pattern = "string", kind => "string" }],
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
  
    newproperty(:deletion) do
      desc 'Whether to replicate the deletion operation'
    end
  
    newproperty(:override) do
      desc 'Whether to override the resources on the destination registry'
    end
  
    newproperty(:enabled) do
      desc 'Whether the policy is enabled or not'
    end
  end
  