Puppet::Type.type(:harbor_retentions).provide(:swagger) do
    mk_resource_methods
    desc 'Swagger API implementation for harbor retention policies'
  
    def self.instances
      api_instance = do_login
  
      retentions = api_instance.retentions_get
  
      retentions.map do |retention_policy|
        new(
          ensure: :present,
          rules: retention_policy.rules,
          scope: retention_policy.scope,
          trigger: retention_policy.trigger,
          id: retention_policy.id,
          provider: :swagger,
        )
      end
    end

    def self.prefetch(resources)
      instances.each do |int|
        if (resource = resources[int.name])
          resource.provider = int
        end
      end
    end

    def do_login
      require 'yaml'
      require 'harbor_swagger_client'
      my_config = YAML.load_file('/etc/puppetlabs/swagger.yaml')
  
      SwaggerClient.configure do |config|
        config.username = my_config['username']
        config.password = my_config['password']
        config.scheme = my_config['scheme']
        config.verify_ssl = my_config['verify_ssl']
        config.verify_ssl_host = my_config['verify_ssl_host']
      end
  
      api_instance = SwaggerClient::ProductsApi.new
      api_instance
    end

    def exists?
      api_instance = do_login
  
      opts = {
        name: resource[:id],
      }
  
      begin
        result = api_instance.retentions_get(opts)
      rescue SwaggerClient::ApiError => e
        puts "Exception when calling ProductsApi->retentions_get: #{e}"
      end
  
      if result.nil?
        false
      else
        true
      end
    end

    def create
      api_instance = do_login


  
      begin
        api_instance.retention_post(np)
      rescue SwaggerClient::ApiError => e
        puts "Exception when calling ProductsApi->retention_post: #{e}"
      end
    end

    def update
      begin
        api_instance.retentions_id_put(id, policy)
      rescue SwaggerClient::ApiError => e
        puts "Exception when calling ProductsApi->retentions_id_put: #{e}"
      end
    end

    def rules=(_value)
        update_retentions_param(resource)
    end

    def scope=(_value)
        update_retuentions_param(resource)
    
    def trigger=(_value)
        update_retentions_param(resource)
    end

    def destroy
        api_instance = do_login
        replication_policy_id = get_retentions_by_id(resource[:id])
    
        begin
          api_instance.retentions_by_id_delete(retentions_id)
        rescue SwaggerClient::ApiError => e
          puts "Exception when calling ProductsApi->retentions_id_delete: #{e}"
        end
    end
end