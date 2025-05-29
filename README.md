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


## The Workflow
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

## docker-compose.yml

### 1. What is docker-compose.yml?
docker-compose.yml is a configuration file written in YAML format, used by Docker Compose to define and manage multi-container Docker applications. It's like a blueprint for setting up an entire stack of services with a single command.<br>

### 2. What is it used for?
1. Define multiple services (e.g. NGINX, MariaDB, WordPress)<br>
2. Specify how each service should run — image to use, ports, environment variables, mounted volumes, etc.<br>
3. Set up dependencies between services, so one container waits for another to be ready<br>
4. Automatically create Docker networks and volumes to allow containers to talk to each other and persist data<br>

Exmaple:<br>

```yaml
version: "3.8"

services:
  web:
    image: nginx
    ports:
      - "80:80"
    volumes:
      - ./conf/nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - app

  app:
    image: myapp
    environment:
      - APP_ENV=production
```
In this example:<br>
 * `web` and `app` are two services<br>
 * `web` uses NGINX and maps port 80<br>
 * `web` depends on `app`<br>
 * A configuration file is mounted into the `web` container<br>
 * `app` has an environment variable set<br>

### 3. How to use
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

