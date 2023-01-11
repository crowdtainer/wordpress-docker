# Wordpress + FPM, Nginx, and Let’s Encrypt

A docker compose configuration to quickly get a Wordpress instance and running, to serve as a starting point for blogs, pages, or installation of WooCommerce and other e-commerce stores.

This is for Crowdtainer's own use and to help others get up and running quickly with their projects.

Credits: Inspired by <a href='https://github.com/evgeniy-khist/letsencrypt-docker-compose'> evgeniy-khist</a>

## Instructions
Set the variables in config.env.example then rename it to config.env.

Tip: For development, you can use the domain 'localhost' in your config.env, which will disable SSL/certificates.

Create the required volumes and run docker:

```sh
docker volume create --name=nginx_ssl
docker volume create --name=certbot_certs

docker-compose --env-file config.env up --build
```

Now configure the Wordpress site by opening localhost in your browser. Once everything is as desired, you can use the "vackup.sh" script to save the volumes and reload it in your production server:

```sh
# source machine:
vackup export VOLUME FILE // Creates a gziped tarball in current directory from a volume

# target machine:
vackup import FILE VOLUME // Extracts a gziped tarball into a volume
```

## Running in production:

If necessary, re-create the volume for Let's Encrypt certificates:

```sh
# Destroy the cert bot container and volume
docker-compose down
docker volume create --name=certbot_certs
```

Change the CERTBOT_TEST_CERT value to 0 in config.env.

Start the containers:

```sh
docker-compose --env-file config.env up --build
# OR
docker-compose up -d --env-file config.env
```

