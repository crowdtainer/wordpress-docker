# Caddy server + FPM + Wordpress

A docker compose configuration to quickly get a Wordpress instance and running, to serve as a starting point for blogs, pages, or installation of WooCommerce and other e-commerce stores.

This is for Crowdtainer's own use and to help others get up and running quickly with their projects.

Create the required volumes and run docker:

```sh
docker volume create --name=caddy_data
docker-compose --env-file config.env up --build

# To read logs:
docker compose logs -f
```

Now configure the Wordpress site by opening localhost in your browser, or using wp-cli tool, e.g.:

```sh
docker-compose --env-file config.env run --rm wp-cli core install --url=example.com --title=Example --admin_user=supervisor --admin_password=strongpassword --admin_email=info@example.com
```

Once everything is as desired, you can use the "vackup.sh" script to save the volumes and reload it in your production server:

```sh
# source machine:
./vackup export VOLUME FILE // Creates a gziped tarball in current directory from a volume

# target machine:
./vackup import FILE VOLUME // Extracts a gziped tarball into a volume
```

## Running in production:

Usually it will be necessary to rename wordpress's hostname (localhost vs example.com). This can be done with the following command:

```sh
docker-compose --env-file config.env run --rm wp-cli search-replace "localhost" "example.de"
```

Build and try:

```sh
docker-compose --env-file config.env up --build
# OR
docker-compose up -d --env-file config.env
```
