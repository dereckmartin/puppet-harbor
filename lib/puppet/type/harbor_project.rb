# frozen_string_literal: true

Puppet::Type.newtype(:harbor_project) do
  desc <<-DESC
@summary Manage projects within Harbor

@example Creating a project in Harbor
    harbor_project { 'my-project':
      ensure           => present,
      public           => 'true',
      members          => ['bob', 'alice'],
      member_groups    => ['This Team', 'That Team'],
      rentention_rules => [
        { 'repository_match' => '**', 'template' => 'latestPushedK', 'count' => '7', tags_match => '**' },
        { 'repository_match' => '**', 'template' => 'latestPulledN', 'count' => '7', tags_match => '**' },
        { 'repository_match' => '**', 'template' => 'nDaysSinceLastPush', 'count' => '7', tags_match => '**' },
        { 'repository_match' => '**', 'template' => 'nDaysSinceLastPull', 'count' => '7', tags_match => '**' },
        { 'repository_match' => '**', 'template' => 'always', 'count' => '7', tags_match => '**' }
    }
DESC

  newparam(:name, namevar: true) do
    desc 'The name of the project'
  end

  newproperty(:public) do
    desc 'Whether to mark the project for public access'
    defaultto :false
    newvalues(:true, :false)
  end

  newproperty(:auto_scan) do
    desc 'Whether to scan images automatically for vulnerabilities when pushing.'
    newvalues(:true, :false)
    defaultto :false
  end

  newproperty(:members, array_matching: :all) do
    desc 'An array of members for the project'
    def insync?(is)
      is.sort == should.sort
    end
  end

  newproperty(:member_groups, array_matching: :all) do
    desc 'An array of member groups for the project'
    def insync?(is)
      is.sort == should.sort
    end
  end

  newproperty(:replication_rules, array_matching: :all) do
    desc 'An array of member groups for the project'
    def insync?(is)
      is.sort == should.sort
    end
  end
end
