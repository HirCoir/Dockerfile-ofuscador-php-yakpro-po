FROM php:8.0-cli

# Install git and other dependencies
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone YAK Pro repository
RUN git clone https://github.com/pk-fr/yakpro-po.git /usr/local/yakpro-po

# Clone PHP-Parser repository
RUN git clone https://github.com/nikic/PHP-Parser.git --branch 4.x /usr/local/yakpro-po/PHP-Parser

# Set working directory
WORKDIR /usr/local/yakpro-po

# Make yakpro-po.php executable
RUN chmod a+x yakpro-po.php

# Create symbolic link
RUN ln -s /usr/local/yakpro-po/yakpro-po.php /usr/local/bin/yakpro-po
RUN ln -s /usr/local/yakpro-po/yakpro-po.php /usr/local/bin/yp

# Copy default configuration file into container
COPY yakpro-po.cnf /usr/local/yakpro-po/yakpro-po.cnf

# Define entrypoint
ENTRYPOINT ["/bin/bash"]
