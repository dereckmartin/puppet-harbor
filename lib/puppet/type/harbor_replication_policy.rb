# frozen_string_literal: true

Puppet::Type.newtype(:harbor_replication_policy) do
  desc <<-DESC
@summary Manage Harbor replication policies

@example Creating a replication policy within Harbor
    harbor_replication_policy { 'example-replication':
      ensure           => 'present',
      deletion         => false,
      enabled          => true,
      override         => false,
      replication_mode => 'pull',
      remote_registry  => 'UPSTREAM',
      filters          => [{'type' => 'name', 'value' => 'exampleproject/**'}, {'type' => 'tag', 'value' => '*'}],
      trigger          => {type => "scheduled", trigger_settings => {cron => "0 0 15 * * *"}},
    }
DESC

  ensurable

  newparam(:name, namevar: true) do
    desc 'The policy name'
  end

  newproperty(:description) do
    desc 'The description of the policy'
    defaultto ''
  end

  newparam(:replication_mode) do
    desc 'The replication policy direction. Can be "push" or "pull"'
    newvalues(:push, :pull)
  end

  newparam(:remote_registry) do
    desc 'The name of registry to push to/pull from'
  end

  newproperty(:dest_namespace) do
    desc 'The destination namespace'
    defaultto ''
  end

  newproperty(:trigger) do
    desc 'Trigger type and trigger settings for policy. type can be "manual", "scheduled", "event_based". "scheduled" requires "trigger_settings" dictionary with "cron" key point to string, e.g. "0 0 15 * * *".'
  end

  newproperty(:filters, array_matching: :all) do
    desc 'The replication policy filter array'
  end

  newproperty(:deletion) do
    desc 'Whether to replicate the deletion operation. Requires trigger "event_based" in order to enable.'
    newvalues(:true, :false)
    defaultto :false
  end

  newproperty(:override) do
    desc 'Whether to override the resources on the destination registry'
    newvalues(:true, :false)
    defaultto :false
  end

  newproperty(:enabled) do
    desc 'Whether the policy is enabled or not'
    newvalues(:true, :false)
    defaultto :true
  end
end
