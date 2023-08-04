#!/bin/bash

# Update the package repository and install necessary packages
sudo apt update
sudo apt install -y wordpress php libapache2-mod-php mysql-server php-mysql

# Configure MySQL
sudo mysql -u root -e "CREATE DATABASE wordpress;"
sudo mysql -u root -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"

# Configure WordPress
sudo cp /usr/share/wordpress/wp-config-sample.php /usr/share/wordpress/wp-config.php
sudo sed -i 's/database_name_here/wordpress/g' /usr/share/wordpress/wp-config.php
sudo sed -i 's/username_here/wordpressuser/g' /usr/share/wordpress/wp-config.php
sudo sed -i 's/password_here/password/g' /usr/share/wordpress/wp-config.php

# Configure Apache
sudo a2enmod rewrite
sudo systemctl restart apache2

# Configure Virtual Host
echo "<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot /usr/share/wordpress
    ServerName example.com
    ServerAlias www.example.com

    <Directory /usr/share/wordpress>
        AllowOverride All
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" | sudo tee /etc/apache2/sites-available/wordpress.conf

sudo a2ensite wordpress
sudo systemctl reload apache2

# Allow HTTP traffic in the firewall
sudo ufw allow 80/tcp

# Output a success message
echo "WordPress has been successfully installed. Access your site at http://http://ec2-18-142-181-133.ap-southeast-1.compute.amazonaws.com/wp-admin/"
