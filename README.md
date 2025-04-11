# inception


## What is NGINX?

NGINX is a versatile, high-performance server primarily used as a web server, reverse proxy, load
balancer, and HTTP cache. It plays a crucial role in modern web infrastructure due to its
efficiency and scalability. Here’s a detailed explanation of what NGINX is and why it is so popular:

Core Functions

    1. Web Server:

    * Static File Serving:
      NGINX is highly efficient at serving static content such as HTML, CSS, JavaScript, images,
      and videos, making it ideal for websites that need to quickly load resources.

    * Dynamic Content Handling:
      While NGINX itself does not directly process dynamic content (e.g., PHP, Ruby, or Python
      ode), it is designed to work seamlessly with backend application servers (like PHP-FPM, Node.
      js, etc.) to deliver dynamic web applications.

    2. Reverse Proxy:

    * Request Forwarding:
      As a reverse proxy, NGINX receives client requests and forwards them to one or more backend
      servers. This setup helps to offload tasks such as SSL/TLS termination (decrypting HTTPS
      traffic), caching responses, or compressing content before sending it back to the client.

    * Improved Security and Load Management:
      By acting as a shield between the public internet and internal servers, NGINX can provide
      additional layers of security, manage traffic spikes, and facilitate scalability.

    3. Load Balancer:

    * Distributing Traffic:
      NGINX can distribute incoming network traffic across multiple backend servers using various
      algorithms (round-robin, least connections, IP-hash, etc.). This ensures that no single
      server bears too much load, which improves overall system reliability and user experience.

    * Fault Tolerance:
      In the event that one server goes down, NGINX can redirect traffic to healthy servers,
      thereby increasing the robustness of the infrastructure.

    4.HTTP Cache:

    * Caching Content:
      NGINX can cache responses from backend services. This not only speeds up content delivery but
      also reduces the load on backend servers by serving cached responses for subsequent requests.



## How to write Dockerfile?

Writing a Dockerfile is all about defining how to build a Docker image for your application.Here’s a simple breakdown, followed by an example:

🧱 Basic Structure of a Dockerfile
```
# 1. Base image
FROM <base-image>

# 2. Metadata (optional but recommended)
LABEL maintainer="yourname@example.com"

# 3. Set working directory
WORKDIR /app

# 4. Copy files from host to container
COPY . .

# 5. Install dependencies
RUN <command to install>

# 6. Expose ports (for apps with networking)
EXPOSE <port-number>

# 7. Set environment variables (optional)
ENV VAR_NAME=value

# 8. Run the application
CMD ["executable", "param1", "param2"]
```

✅ Logical (Recommended) Order

1. `FROM` – Always first. Sets the base image.

2. `LABEL / ENV` – Optional metadata or configuration.

3. `WORKDIR` – Before any file operations; sets the context for COPY and RUN.

4. `COPY / ADD` – Copy app files after WORKDIR is set.

5. `RUN` – Install dependencies. Run commands.

6. `EXPOSE` – Informational. Comes after setup.

7. `CMD / ENTRYPOINT` – Last, as it defines the default behavior.

 