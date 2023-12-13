import os
import docker
import sys
from docker.errors import DockerException

USERNAME_VAR = 'GITHUB_ACTOR'
TOKEN_VAR = 'GHCR_TOKEN'

def check_env():
    """
    Check if required environment variables are set.
    Returns True if all required environment variables are set, False otherwise.
    """
    username = os.getenv(USERNAME_VAR)
    token = os.getenv(TOKEN_VAR)
    return bool(username and token)

def docker_login():
    username = os.getenv(USERNAME_VAR)
    token = os.getenv(TOKEN_VAR)
    client = docker.from_env()
    try:
        client.login(username=username, password=token, registry='https://ghcr.io')
    except DockerException as e:
        print(f"Error logging into Docker: {e}")
        sys.exit(1)

    return client

def start_container(image_name, host_port, container_port):
    client = docker_login()

    try:
        print(f"Pulling image {image_name}...")
        image = client.images.pull(image_name)

        print(f"Running image {image_name} on port {host_port}:{container_port}...")
        port_bindings = {container_port: host_port}
        container = client.containers.run(image, detach=True, ports=port_bindings)
        print(f"Container {container.id} is running.")
        return container.id

    except DockerException as e:
        print(f"An error occurred: {e}")
        sys.exit(1)

def stop_container(container_id):
    client = docker_login()

    try:
        container = client.containers.get(container_id)
        container.stop()
        print(f"Container {container_id} has been stopped.")

    except DockerException as e:
        print(f"An error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if not check_env():
        print("Required environment variables are not set.")
        sys.exit(1)

    if len(sys.argv) < 3:
        print("Usage: script.py start <image_name> <host_port> <container_port> | stop <container_id>")
        sys.exit(1)

    command = sys.argv[1]
    if command == "start":
        if len(sys.argv) != 5:
            print("Usage: script.py start <image_name> <host_port> <container_port>")
            sys.exit(1)
        
        image_name = sys.argv[2]
        host_port = int(sys.argv[3])
        container_port = int(sys.argv[4])
        container_id = start_container(image_name, host_port, container_port)
        print(container_id)  # Print the container ID as the last line for easy parsing
    elif command == "stop":
        container_id = sys.argv[2]
        stop_container(container_id)
    else:
        print("Invalid command. Use 'start' or 'stop'.")
        sys.exit(1)
