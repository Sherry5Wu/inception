# inception

## NGINX

NGINX is a versatile, high-performance server primarily used as a web server, reverse proxy, load balancer, and HTTP cache. It plays a crucial role in modern web infrastructure due to its efficiency and scalability. Here’s a detailed explanation of what NGINX is and why it is so popular:<br>

Core Functions<br>

    1. Web Server:

    * Static File Serving:
      NGINX is highly efficient at serving static content such as HTML, CSS, JavaScript, images, and videos, making it ideal for websites that need to quickly load resources.

    * Dynamic Content Handling:
      While NGINX itself does not directly process dynamic content (e.g., PHP, Ruby, or Pythonode), it is designed to work seamlessly with backend application servers (like PHP-FPM, Node.js, etc.) to deliver dynamic web applications.

    2. Reverse Proxy:

    * Request Forwarding:
      As a reverse proxy, NGINX receives client requests and forwards them to one or more backend servers. This setup helps to offload tasks such as SSL/TLS termination (decrypting HTTPS traffic), caching responses, or compressing content before sending it back to the client.

    * Improved Security and Load Management:
      By acting as a shield between the public internet and internal servers, NGINX can provide additional layers of security, manage traffic spikes, and facilitate scalability.

    3. Load Balancer:

    * Distributing Traffic:
      NGINX can distribute incoming network traffic across multiple backend servers using various algorithms (round-robin, least connections, IP-hash, etc.). This ensures that no single server bears too much load, which improves overall system reliability and user experience.

    * Fault Tolerance:
      In the event that one server goes down, NGINX can redirect traffic to healthy servers, thereby increasing the robustness of the infrastructure.

    4.HTTP Cache:

    * Caching Content:
      NGINX can cache responses from backend services. This not only speeds up content delivery but also reduces the load on backend servers by serving cached responses for subsequent requests.

## WordPress
WordPress is a free and open-source content management system (CMS) that allows you to create and manage websites easily, even without deep technical knowledge.<br>
Key Features of WordPress:<br>
    - User-Friendly Interface: Write, edit, and manage content through an intuitive dashboard.<br>
    - Themes & Plugins: Thousands of free and premium themes for design, and plugins to extend functionality (e.g., SEO, contact forms, security).<br>
    - Customizable: Full access to the code for developers who want to build custom themes or plugins.<br>
    - Open Source: Built with PHP and MySQL, licensed under the GPL.<br>
    - Community Support: Massive global community, with extensive documentation and support forums.<br>

### What is PHP_FPM
  - PHP-FPM stands for FastCGI Process Manager.<br>
  - It’s a specialized PHP interpreter designed to handle multiple concurrent PHP requests efficiently.<br>
  - PHP-FPM runs as a separate service/process pool that manages PHP workers waiting to process requests.<br>

Benefits of PHP-FPM vs plain PHP<br>
| Feature                      | PHP CLI (`php`)                 | PHP-FPM                                           |
| ---------------------------- | ------------------------------- | ------------------------------------------------- |
| Intended Use                 | Command line scripts, cron jobs | Web server environment                            |
| Handles Multiple Requests    | No (one script at a time)       | Yes (multiple PHP workers)                        |
| Performance                  | Limited concurrency             | High concurrency & process management             |
| Integration with Web Servers | Minimal                         | Full FastCGI support for NGINX/Apache             |
| Process Management           | None                            | Manages pools, worker lifetimes, dynamic spawning |

## Adminer
Adminer is a lightweight, full-featured database management tool written in a single PHP file. It’s used to interact with databases via a web interface, much like phpMyAdmin, but it’s simpler, faster, and more portable.<br>

Key Features:
  * Supports multiple databases: MySQL, PostgreSQL, SQLite, MS SQL, Oracle, MongoDB (via plugins), and others.<br>
  * Single-file deployment: Just one PHP file to upload and run.<br>
  * Secure by design: Minimal footprint, CSRF protection, and session-based login.<br>
  * User-friendly UI: Clean and fast interface to manage tables, run queries, edit data, and manage users.<br>
  * Customizable via plugins: Extendable with additional functionality as needed.<br>

## Redis
Redis (REmote DIctionary Server) is a fast, in-memory data store used as a database, cache, and message broker. It's widely used in modern applications where performance and scalability are crucial.<br>

What Is Redis Used For?
| Use Case                | Description                                               |
| ----------------------- | --------------------------------------------------------- |
| **Caching**             | Store frequently accessed data to reduce DB load.         |
| **Session Storage**     | Store user session data in web apps.                      |
| **Message Queues**      | Build pub/sub or task queues (e.g., with Celery or Bull). |
| **Real-Time Analytics** | Track counters or metrics in real-time.                   |
| **Leaderboard Systems** | Use sorted sets for game scores, rankings, etc.           |

## FTP Server
File transfer protocol server (commonly known as FTP Server) is computer software that facilitates the secure exchange of files over a TCP/IP network. It runs the file transfer protocol (FTP), a standard communication protocol that operates at the network level, to establish a secure connection between the devices in a client-server architecture and efficiently transmit data over the internet.<br>

### Pure-FTPd
Pure-FTPd is a free, open-source, and secure FTP server software designed for Unix-like operating systems (Linux, *BSD, macOS, etc.). It aims to be simple, efficient, and secure, and is often used in environments where ease of configuration and security are important.
Recommended for Docker + WordPress.<br>
🟢 Lightweight and secure<br>
🟢 Easy TLS/SSL setup<br>
🟢 Virtual users support<br>
🟢 Well-maintained and commonly used in containerized environments<br>
🟢 Readily available as a Docker image (stilliard/pure-ftpd)<br>
🔴 Doesn't include a web UI (CLI or config-based)<br>
Best for: Simple, secure, and scriptable FTP container setups.<br>

✅ Why Pure-FTPd?
  * Works well in Docker<br>
  * Secure by default<br>
  * Can limit access to only the WordPress volume<br>
  * Supports TLS and passive mode (important for production)<br>

#### Passive mode
Passive mode (PASV) is one of the two modes in FTP used to establish data connections between the client and server (the other is active mode). It’s particularly important when the client is behind a firewall or NAT — like in most modern setups (including Docker or home networks).<br>

##### Two Connections in FTP:<br>
FTP uses two TCP connections:
  1. Control connection – on port 21, used for commands like login, list, upload, download.<br>
  2. Data connection – used for transferring files or directory listings.<br>
How the data connection is opened differs between active and passive mode.<br>

##### Passive Mode: Client Connects to Server for Data
  * The client initiates both the control and data connections.<br>
  * The server tells the client which port to connect to for data.<br>
  * Typically used behind firewalls and NAT because inbound connections to the client are blocked, but outbound ones are allowed.<br>

##### Flow
```pgsql
1. Client connects to server:21 (control)
2. Client sends PASV command
3. Server replies with: "Connect to me on IP:x,y,z,w and port P"
4. Client connects to server:port (data)
5. Data (like file or listing) is transferred
```
##### In Docker (or cloud environments):
  * Servers (like Pure-FTPd) must declare a passive port range (e.g., 30000–30042).<br>
  * You expose these in `docker-compose.yml` or `-p` flags.<br>
  * You configure the server to advertise the public IP and port.<br>

## Netdata
Netdata is a real-time performance monitoring and troubleshooting tool for systems and applications. It's open-source and designed to be lightweight, easy to install, and visually rich, making it ideal for both system admins and developers who want instant insights into their infrastructure.<br>

What Netdata Does:
  * Monitors: CPU, memory, disks, network, services, applications (like MySQL, NGINX, Docker, etc.), and more.<br>
  * Visualizes: Beautiful, interactive dashboards with live updates (per second or faster).<br>
  * Alerts: Comes with pre-configured health alarms and supports custom alert rules.<br>
  * Troubleshoots: Helps you identify bottlenecks, misbehaving processes, or system issues quickly.<br>

## lifecycle of a Docker image and container

### Build Time: (Happens once, when the image is built)
This is when Dockerfile instructions are executed to assemble an image.<br>

#### Flow
1. Dockerfile starts<br>
    FROM, COPY, RUN, etc. instructions are processed.<br>
2. Copies config + entrypoint<br>
    COPY ./entrypoint.sh /usr/local/bin/<br>
    COPY ./my-mariadb-server.cnf /etc/mysql/conf.d/<br>
3. Image is built<br>
    Final image is created with your app + config + entrypoint baked in.<br>
    Tagged, ready for docker run.<br>

At this point, nothing is "running" yet — it's just building the image layer by layer.<br>

### Run Time: (Happens every time the container starts)
This is when you start a container from that image (docker run, docker-compose up, etc.).<br>
#### Flow
1. Container starts<br>
    Docker launches the container based on the image.<br>
2. entrypoint.sh executes<br>
    The image defines ENTRYPOINT ["entrypoint.sh"], so this script runs first.<br>
3. Custom configs like my-mariadb-server.cnf are picked up<br>
    entrypoint.sh or mysqld reads /etc/mysql/conf.d/my-mariadb-server.cnf.<br>
    The script may also set env vars, create users, init DBs, etc.<br>
4. mysqld starts<br>
    The final command in entrypoint.sh usually ends with:<br>
    ```sh
    exec "$@"
    ```
    This passes control to the CMD (e.g., CMD ["mysqld"]), launching the DB server.<br>


### Summary Diagram
```sql
Build Time:
  Dockerfile:
    ↓
  Copies config + entrypoint
    ↓
  Sets up image

Run Time:
  Container starts
    ↓
  entrypoint.sh executes
    ↓
  my-mariadb-server.cnf configures mysqld
    ↓
  mysqld starts (via CMD or exec "$@")
```

## Dockerfile?

Writing a Dockerfile is all about defining how to build a Docker image for your application.
It is like a blueprint. Here’s a simple breakdown, followed by an example:

### 1. Basic Structure of a Dockerfile
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

### 2. Logical (Recommended) Order

    1. `FROM` – Always first. Sets the base image.

    2. `LABEL / ENV` – Optional metadata or configuration.

    3. `WORKDIR` – Before any file operations; sets the context for COPY and RUN.

    4. `COPY / ADD` – Copy app files after WORKDIR is set.

    5. `RUN` – Install dependencies. Run commands.

    6. `EXPOSE` – Informational. Comes after setup.

    7. `CMD / ENTRYPOINT` – Last, as it defines the default behavior.

### 3. Commands:
`FROM`: Specifies the base image to use (must be the first non-comment instruction)<br>
`RUN`: Runs a command in a new container and creates a new image layer<br>
`COPY`: Copies files/folders from your local machine into the image<br>
`ADD`: Similar to COPY, but supports URLs and extracting archives<br>
`CMD`: Sets the default command to run when the container starts<br>
`ENTRYPOINT`: Sets the main executable, allowing CMD to act as its default arguments<br>
`ENV`: Sets an environment variable<br>
`WORKDIR`: Sets the working directory for subsequent commands<br>
`EXPOSE`: Documents the port the container listens on (informational only)<br>
`ARG`: Defines build-time variables<br>
`LABEL`: Adds metadata to the image (e.g., maintainer info)<br>
`USER`: Sets the user under which to run the container processes<br>
`VOLUME`: Declares mount points for external storage<br>
must be written in uppercase (by convention and practice).  But technically...Docker does not care about case — it’s not case-sensitive.This means run, Run, or RUN will work the same.<br>

Compare CMD and ENTRYPOINT<br>
|  Feature   |         ENTRYPOINT             |                  CMD                  |
|:-----------|:-------------------------------|:--------------------------------------|
| Purpose    | Main process                   | Default arguments                     |
| Override   | Harder to override             | Easy to override via docker run       |
| Syntax     | Usually ["executable", "arg"]  | ["arg1", "arg2"]                      |

Example 1, just use `CMD`<br>
```bash
FROM alpine
CMD ["echo", "Hello from CMD"]
```
Run,
```bash
docker run myimage echo "Hi there"
```
Output is,
```bash
Hi there
```
`CMD` is overrided by`docker run`<br>

Example 2, just use `ENTRYPOINT`<br>
```bash
FROM alpine
ENTRYPOINT ["echo", "This is ENTRYPOINT:"]
```
Run,
```bash
docker run myimage "Hello"
```
Output is,
```bash
This is ENTRYPOINT: Hello
```
`ENTRYPOINT` cant be overrided by`docker run`, but just added the argument after it<br>

Example 3, use both `CMD` and `ENTRYPOINT`<br>
```bash
FROM alpine
ENTRYPOINT ["echo", "Message:"]
CMD ["Default message"]
```
Run,
```bash
docker run myimage
```
Output is,
```bash
Message: Default message
```
Run,
```bash
docker run myimage "Custom message"
```
Output is,
```bash
Message: Custom message
```
In this case, `CMD` is treated as the default argument to `ENTRYPOINT`, rather than the command itself.<br>

### 4. Syntax Tips
Always use `--no-cache` when installing packages in Alpine<br>
Use `\` to split long `RUN` commands across multiple lines<br>
Keep `COPY/ADD` close to RUN commands that use the copied files<br>
Order matters: changing earlier instructions will invalidate Docker cache for all later steps<br>

### 5. How a Dockerfile is Exectued
When you run:
```sh
docker build -t my-image .
```
Docker reads and executes the Dockerfile line-by-line to build a new image.<br>

1. Dockerfile is Parsed <br>
Docker reads the Dockerfile top to bottom. Each instruction (`FROM`, `RUN`, `COPY`, etc.) creates a layer in the image (except some special cases like `ARG`, `ENV`, `LABEL`).

2. Base Image is Pulled<br>
```sh
FROM alpine:3.20
```
Docker pulls this base image from Docker Hub (if not already in local cache). This is the starting point of the image.<br>

3. Instructions are Executed One by One<br>
Each instruction creates a new intermediate container, runs the command inside that container, and then commits the result as a new image layer.<br>

4.  Caching Is Used<br>
Docker caches each layer. If nothing has changed in an instruction or its context, Docker will reuse the cached result to speed up builds.<br>
So, order matters — changing a line early in the Dockerfile can invalidate the cache for all subsequent lines.<br>

5. Final Image Is Built<br>
After all instructions are executed, Docker packages the final state of the last container as an image and tags it (e.g., my-image:latest).<br>


### 5. set -eux
set -eux is a commonly used command combination in shell scripts to improve the transparency, robustness, and debuggability of script execution. It is also very useful in the RUN command of a Dockerfile.<br>
You will often see a more complete version written as:<br>
    -e: Exit the script immediately if any command fails (i.e., returns a non-zero exit status).<br>
    -u: Exit the script with an error if any unset (undefined) variable is used (helps catch typos in variable names).<br>
    -x: Print each command before executing it (useful for debugging).<br>

## Docker Compose

### 1. What is docker compose?
Docker Compose is a tool that helps you define and run multi-container Docker applications. It uses a YAML file (`docker-compose.yml`) to configure your application's services, networks, and volumes, making it easier to orchestrate complex setups with multiple containers (like a web server, database, and reverse proxy).<br>

### 2. What is it used for?
1. Define multiple services (e.g. NGINX, MariaDB, WordPress)<br>
2. Specify how each service should run — image to use, ports, environment variables, mounted volumes, etc.<br>
3. Set up dependencies between services, so one container waits for another to be ready<br>
4. Automatically create Docker networks and volumes to allow containers to talk to each other and persist data<br>

### 3. What should a docker-compose.yml file contain?
A `docker-compose.yml` file typically includes the following main sections:

#### 1. `version:`
Specifies the Compose file format version.
```yaml
version: '3.8'  # or '3', '2.4', etc., depending on your Docker version
```
#### 2. `services:`
Defines the different containers (services) that make up your application.<br>
Each service has options like:
  * `image`: Docker image to use.
  * `build`: Path to Dockerfile to build a custom image.
  * `ports`: Host-to-container port mapping.
  * `volumes`: Mount volumes for persistence or code sharing.
  * `environment`: Environment variables.
  * `depends_on`: Define service startup order.
  * `networks`: Which network(s) the service is attached to.
Example:
```yaml
services:
  web:
    build: ./web
    ports:
      - "8080:80"
    volumes:
      - ./web:/var/www/html
    depends_on:
      - db

  db:
    image: mariadb:10.5
    environment:
      MYSQL_ROOT_PASSWORD: example
    volumes:
      - db_data:/var/lib/mysql
```
#### 3. `volumes:`
Defines named volumes that can be reused across services.
```yaml
volumes:
  db_data:
```
#### 4. `networks:` (optional)
Defines custom networks (bridge, host, or overlay).
```yaml
networks:
  my_network:
    driver: bridge
```
#### 5. Optional Extras
  * `restart:`: Controls restart policy (`always`, `on-failure`, etc.).
  * `command:`: Override the default command in the container.
  * `entrypoint:`: Override the default entrypoint.
  * `healthcheck:`: Define health check instructions.



Example: A Full Setup<br>

```yaml
version: '3.8'

services:
  nginx:
    image: nginx:alpine
    ports:
      - "443:443"
      - "80:80"
    volumes:
      - ./nginx/conf:/etc/nginx/conf.d
    depends_on:
      - wordpress

  wordpress:
    image: wordpress:php8.2-fpm
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: root
      WORDPRESS_DB_PASSWORD: example
    volumes:
      - wordpress_data:/var/www/html
    depends_on:
      - db

  db:
    image: mariadb:10.5
    environment:
      MYSQL_ROOT_PASSWORD: example
    volumes:
      - db_data:/var/lib/mysql

volumes:
  wordpress_data:
  db_data:
```
### 4. How to use
You can start the entire application stack with a single command:<br>
```bash
docker-compose up -d
```

## Some Shell functions

In shell scripting, commands return an exit code, not true/false like in other languages.<br>
    - Exit code 0 → success → true
    - Exit code 1 (or other non-zero) → failure → false

### 1. until ...; do ...; done
This is a Shell loop that works like this:<br>
    -- It runs the command after until<br>
    -- If the command fails (i.e., returns non-zero exit status), then the body inside do ... done will execute<br>
    --This continues looping until the command succeeds<br>

In simple words:<br>
    -- "Keep doing something until the condition becomes true (success)."<br>

### 2. while ...; do ...; done
syntax: <br>
```shell
while <condition>; do
    # commands to run while the condition is true
done
```
How it works:<br>
    1.The condition (usually a command or expression) is evaluated.<br>
    2.If the exit status is 0 (i.e., the command succeeds, which means “true” in shell terms), then the block inside do ... done runs.<br>
    3.After running the block, it goes back and checks the condition again.<br>
    4.This repeats as long as the condition stays true.<br>
    5.When the condition returns a non-zero exit code (i.e., fails or is “false”), the loop stops.<br>

Example<br>
```shell
counter=1

while [ $counter -le 5 ]; do
    echo "Counter is $counter"
    counter=$((counter + 1))
done
```
Output:<br>
```shell
Counter is 1
Counter is 2
Counter is 3
Counter is 4
Counter is 5
```
Key Difference in One Line<br>
|: Syntax	     |: Loop runs when...               |:  Ends when...                     |
|--------------|----------------------------------|------------------------------------|
| while loop   | Condition is true (exit code 0)  |   Condition is false (non-zero)    |
|--------------|----------------------------------|------------------------------------|
| until loop   | Condition is false (non-zero)    |   Condition is true (exit code 0)  |

### 3. if
#### 3.1 syntax<br>
```shell
if [ condition ]; then
    # commands to run if condition is true
fi
```
```shell
if [ condition ]; then
    # true block
else
    # false block
fi
```
```shell
if [ condition1 ]; then
    # commands if condition1 is true
elif [ condition2 ]; then
    # commands if condition2 is true
else
    # commands if none are true
fi
```
#### 3.2 Common Conditional Operators<br>
Integer comparisons:
| Operator | Meaning               |
| -------- | --------------------- |
| `-eq`    | equal to              |
| `-ne`    | not equal to          |
| `-lt`    | less than             |
| `-le`    | less than or equal to |
| `-gt`    | greater than          |
| `-ge`    | greater than or equal |

Example:<br>
```shell
if [ $x -gt 10 ]; then echo "x > 10"; fi
```
String comparisons:
| Operator | Meaning             |
| -------- | ------------------- |
| `=`      | equal to            |
| `!=`     | not equal to        |
| `-z`     | string is empty     |
| `-n`     | string is not empty |

Example:<br>
```shell
if [ "$name" = "admin" ]; then echo "Welcome"; fi
```
File checks:
| Operator  | Meaning                |
| --------- | ---------------------- |
| `-e file` | file exists            |
| `-f file` | file is a regular file |
| `-d file` | file is a directory    |
| `-r file` | file is readable       |
| `-w file` | file is writable       |
| `-x file` | file is executable     |

Example:<br>
```shell
if [ -f /etc/passwd ]; then echo "Found passwd file"; fi
```
#### 3.3 Notes
Always add spaces around the brackets:
```shell
if [ "$var" = "hello" ]; then ...
```
❌ Wrong: [ `"$var"="hello"` ]<br>
✅ Right: [ `"$var" = "hello"` ]<br>

Quote variables to prevent word-splitting or errors<br>

There must be spaces around the square brackets and inside them:
```shell
if [ $x -gt 3 ]; then echo "x is greater than 3"; fi
```
❌ Wrong: [`$x -gt 3`]<br>
✅ Right: [ `$x -gt 3` ]<br>

### Parameter Expansion
Parameter expansion is a feature in Bash that allows you to manipulate and validate variable values when using them.<br>
The basic syntax is:
```bash
${VARIABLE}
```
Common Forms of Parameter Expansion (with examples)
| Syntax            | Meaning                                          | Example                      |
| ----------------- | ------------------------------------------------ | ---------------------------- |
| `${VAR}`          | Get the value of `VAR`                           | `echo ${NAME}`               |
| `${VAR:-default}` | Use `default` if `VAR` is unset or empty         | `echo ${NAME:-Anonymous}`    |
| `${VAR:=default}` | Assign `default` to `VAR` if it's unset or empty | `echo ${NAME:=Default}`      |
| `${VAR:?error}`   | Show error and exit if `VAR` is unset or empty   | `: ${NAME:?Please set NAME}` |
| `${VAR:+alt}`     | Use `alt` **only if** `VAR` is set and not empty | `echo ${NAME:+Set}`          |


## VM
I installed debian.

### VM installation
1. Download the iso version of debian(https://www.debian.org/distrib/), I choosed "64-bit PC netinst iso" version.

2. Open `Oracle Virtual Box Manager`......


### VM config
1. Update Your System
```bash
sudo apt update && sudo apt upgrade -y
```
2. Install Docker
Docker isn't included by default in Debian's repositories with the latest version, so use the official Docker install script or manual setup.
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
3. Install Docker Compose
The current Docker CLI includes Compose as a plugin (`docker compose` instead of `docker-compose`).
To check:
```bash
docker compose version
```
If not present, install manually:
```bash
sudo apt install docker-compose-plugin
```
4. Enable Docker to Run Without sudo (Optional but useful)
```bash
sudo usermod -aG docker $USER
newgrp docker
```
5. (Optional but Useful) Install Supporting Tools
These are helpful during development and troubleshooting:
```bash
sudo apt install -y vim htop curl wget git openssl openssl-server net-tools
```
6. Configure DNS for Local Domain (e.g., `jingwu.42.fr`)
If your project requires access via a local domain:
  * Edit /etc/hosts on your host (or within VM if testing locally):
  ```bash
  127.0.0.1 jingwu.42.fr
  ```
![alt text](./images/change_localhost.png)

7. sshd_config and ssh_config
If you can't find `sshd_config` and `ssh_config`files in `ssh` folder, it means you haven't install `openssl` and `openssl-server` yet.<br>
sshd_config:
```bash
sudo vim /etc/ssh/sshd_config
```
uncomment `port` and `PermitRootLogin`, change the `port` to `4241`, and `PermitRootLogin` to `no`.
![alt text](./images/sshd_config.png)

ssh_config:
```bash
sudo vim /etc/ssh/ssh_config
```
uncomment `port`, and change it to `4241`.
![alt text](./images/ssh_config.png)

After the changes you can check if the ports have been changed successfully by below command:
```bash
systemctl status ssh | grep 4241
```
![alt text](./images/checking_port_setting.png_)

### Add port 4241 to VM
1. In the VirtualBox Manager: Setting->Network, In "Adapter 1" set "Attached to" to "NAT"(it should be the default one). Click "Advanced" -> "Port Forwarding"
![alt text](./images/VM_network_setting1.png)

2. In "Port Forwarding Rules" page, click the add button on the top left, set the "Host Port" and "Guest Port" to 4241.
![alt text](./images/VM_network_setting2.png)

### Copy the project to VM
1. connect with vm
```bash
ssh localhost -p 4241
```
Note: here is using lowercase 'p'.
![alt text](./images/connect_VM.png)
2. copy the project from physical machine to the vm
```bash
scp -P 4241 -r /home/jingwu/projects/inception jingwu@127.0.0.1:/home/jingwu
```
Note: here is using uppercase 'P'.
remember:<br>
 - change the port "4241" to the one you use<br>
 - change "/home/jingwu/projects/inception" to the local path of your project;<br>
 - change the user name "jingwu" in "jingwu@127.0.0.1" to your vm username;<br>
 - change "/home/jingwu" to the correct remote path;<br>

### some errors I met
After "make", if you see the below error:
![alt text](./images/make_error.png)

Reason: This means your user (jingwu) does not have permission to use Docker directly.
To fix it:
1. switch to root
```bash
su -
```
2. run below command
```bash
usermod -aG docker jingwu
```
3. restart the VM
4. After restart , using `groups` command to check if the `docker` listed.(should be listed)

### Some commands
#### Add user to sudoers file![alt text](image.png)
Suggest to add the user you use into sudo file:
```bash
su -
```
After input the root password, then open `sudoers`
```bash
vim /etc/sudoers
```
At the `# User privilege specification` section added:
```bash
root ALL=(ALL:ALL) ALL
jingwu ALL=(ALL:ALL) NOPASSWD: ALL
```
Change `jingwu` to your username.
Then run the below command:
```bash
usermod -aG sudo jingwu
```
Again, change `jingwu` to your username.

### Container debugging
After successfully `make` the `Makefile`, we need to make sure all the containers are runnning successfully.
1. Use `docker ps` to shows a list of running containers on your system.
```bash
docker ps
```
![alt text](./images/docker_ps.png)

2. To make sure if each container runs correctly and successfully, we need to check logs of each container:
```bash
docker logs nginx
```
![alt text](./images/logs_nginx.png)
```bash
docker logs mariadb
```
![alt text](./images/mariadb_logs.png)

```bash
docker logs wordpress
```
![alt text](./images/wordpress_logs.png)

If all the containers are up, and each container's log are no errors, then it means all the containers are running successfully.

### Wordpress website

#### wordpress frontend
Frontend's address is `https://jingwu.42.fr`, remember to change `jingwu` to your login name.
![alt text](./images/wordpress_frontend.png)

#### wordpress admin page

Address`https://jingwu.42.fr/wp-admin`, you can use the admin user you setted in'.env' file to login.
![alt text](./images/wp-admin_login.png)

### Entry mariadb
1. Get into the mariadb container
```bash
docker exec -t mariadb mariadb
```
![alt text](./images/get-into-mariadb.png)
2. Show the database
```bash
SHOW DATABASES;
```
![alt text](./images/show-database.png)
4. Show the tables
```bash
SHOW TABLES;
```
![alt text](./images/show-tables.png)
5. Get into wordpress database
```bash
USE wordpress_db;
```
![alt text](./images/use-db.png)

6. Checking the user table, there should have two users we created
```bash
select * from wp_users;
```
![alt text](./images/users.png)

### Checking if Redis works
```bash
docker exec -it redis redis-cli -a <your_redis_password> set testkey "hello"
```
![alt text](./images/redis-set.png)

```bash
docker exec -it redis redis-cli -a <your_redis_password> get testkey
```
![alt text](./images/redis-get.png)

### pure-ftpd

Next testing steps
After docker-compose up:
1️⃣ Try connecting via an FTP client:
```bash
ftp localhost
```
![alt text](./images/ftp.png)
### Static-website

```bash
curl -I http://localhost:8080
```
![alt text](./images/static-website-1.png)
And visite the website using 'http://localhost:8080'
![alt text](./images/static-website-2.png)

### Netdata

Website 'http://localhost:8082'
![alt text](./images/netdata.png)

## Concepts

### How Docker and docker compose work
#### Docker
Docker is a tool that packages your app together with everything it needs to run — like the code, libraries, and settings — into a container.<br>
✅ Think of a container like a lunchbox.<br>
Inside the lunchbox, you have everything your meal (app) needs — no matter where you open it, it works the same.<br>
So whether you’re on your laptop, your colleague’s PC, or a cloud server — the app runs the same way.<br>

⚙️ How does Docker work?<br>
1️⃣ You write instructions (a Dockerfile) that describe:<br>
  * What base system to use (e.g., Debian, Alpine)<br>
  * What files to copy<br>
  * What commands to run<br>
2️⃣ Docker builds an image from that file (a kind of app snapshot).<br>
3️⃣ You tell Docker to run the image → it creates a container and your app runs inside it.<br>

#### Docker compose
Docker Compose helps you run multiple containers at once, and connect them easily.<br>
Think of Compose like a kitchen recipe for a whole meal — not just the lunchbox for one dish.<br>
It tells Docker:<br>
  * Start the web app container<br>
  * Start the database container<br>
  * Link them together<br>
  * Open port 8080 so I can access it<br>
You write these instructions in a simple YAML file (usually docker-compose.yml).<br>

### The difference between a Docker image used with docker compose and without docker compose?
When using the image without docker compose, you run the image manually, you do something like:<br>
```bash
docker build -t myapp .
docker run -p 8080:80 myapp
```
You are:<br>
  * Starting a single container at a time.<br>
  * Manually managing options (e.g. ports, volumes, env vars).<br>
  * If you have multiple services (e.g. app + db), you must start and network them yourself.<br>

If you using the image with docker compose, you:
  * Still use the exact same image (or build the same one from the Dockerfile).<br>
  * But you define how to run it in a docker-compose.yml file.<br>
Compose:
  * Automatically sets up networking (so web can reach db by name).<br>
  * Manages multiple containers as one unit.<br>
  * Makes it easy to start/stop/rebuild all containers (docker-compose up, down).<br>

Docker vs Docker Compose: commands to build, run, and stop<br>
| Action             | 🐳 **Docker (single container)**     | 🧩 **Docker Compose (multi-container)**                                                                                                                  |
| ------------------ | ------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Build image**    | `docker build -t myapp .`            | `docker compose build` <br>*(if using `build:` in YAML)*                                                                                                 |
| **Run container**  | `docker run -d -p 8080:80 myapp`     | `docker compose up` <br>or<br> `docker-compose up -d` *(for detached mode)*                                                                              |
| **Stop container** | `docker stop <container_name_or_id>` | `docker compose stop` *(stops containers but keeps network/volumes)* <br> `docker compose down` *(stops + removes containers, network, default volumes)* |

### The benefit of Docker compared to VMs
 core difference:<br>
  * VMs (Virtual Machines) virtualize entire computers — each VM runs its own OS + kernel + apps.<br>
  * Docker (containers) virtualizes at the app level — containers share the host OS kernel but isolate the app environment.<br>

Why Docker shines<br>
  * Speed: You can spin up a container in seconds → great for CI, testing, microservices.<br>
  * Density: You can run 10s or 100s of containers where you might run a few VMs.<br>
  * Dev → Prod consistency: Containers ensure “works on my machine” = “works in prod”.<br>
  * Easy orchestration: Tools like Docker Compose, Swarm, Kubernetes.<br>

When VMs still make sense, if you need:<br>
  * Full OS isolation (e.g., for untrusted workloads)<br>
  * Different kernel versions<br>
  * Legacy OSes<br>

#### What is Docker Network
A Docker network is how containers talk to:<br>
  * each other (container-to-container communication)<br>
  * the outside world (internet or your machine)<br>
You can think of it as the virtual bridge or switch that connects your containers.<br>

Types of Docker networks (simple view):<br>
| Network type    | What it means                                                                                                |
| --------------- | ------------------------------------------------------------------------------------------------------------ |
| `bridge`        | Default for single-host Docker. Containers connect via a private network and can talk using container names. |
| `host`          | Container shares the host’s network (no isolation).                                                          |
| `none`          | No network. The container is fully isolated.                                                                 |
| `custom bridge` | Like `bridge` but created by you → lets containers talk using names and gives more control.                  |

Related commands: `docker network ls` and `docker network inspect`<br>
