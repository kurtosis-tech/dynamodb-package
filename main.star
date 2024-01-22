NAME = "dynamodb"
IMAGE = "instructure/dynamo-local-admin"
SERVER_PORT = 8000

def run(plan):
    """
    Spins up AWS dynamodb.
    """
    get_recipe = GetHttpRequestRecipe(
        port_id = "server",
        endpoint = "/create-table",
    )

    ready_conditions_config = ReadyCondition(
        recipe = get_recipe,
        field = "code",
        assertion = "==",
        target_value = 200,
        interval = "2s",
        timeout = "10s",
    )

    service_config= ServiceConfig(
        image = IMAGE,
        ports = {
            "server": PortSpec(number = SERVER_PORT, transport_protocol = "TCP")
        },
        ready_conditions=ready_conditions_config,
    )

    service = plan.add_service(name = NAME, config = service_config)
    endpoint = "http://{}:{}".format(service.hostname, service.ports["server"].number)

    return {"service-name": NAME, "endpoint": endpoint}
