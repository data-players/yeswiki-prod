FROM lavoweb/php-7.3:composer

# Add MySQLi
RUN docker-php-ext-install mysqli

# Add Chromium browser to enable pdf creation
RUN apt-get --allow-releaseinfo-change update && apt install -y --no-install-recommends \
    chromium \
    git
RUN rm -rf /var/cache/apk/* \
    rm -rf /tmp/*

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Node & NPM & Yarn
RUN curl -sL https://deb.nodesource.com/setup_14.x  | bash -
RUN apt-get install -y --no-install-recommends nodejs
RUN curl -L https://npmjs.org/install.sh | sh
RUN npm install -g yarn

COPY start.sh /start.sh

RUN chmod 777 /start.sh

CMD /start.sh
