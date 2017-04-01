# # docker build -t spiti-node .
#FROM buildpack-deps:jessie-scm
FROM markadams/chromium-xvfb

# Install node
RUN set -x \
    && curl -sL https://deb.nodesource.com/setup_7.x | bash - \
    && apt-get install -y \
        nodejs
#    && npm install -g npm

# Install Chrome
#RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list
#
#RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
#
#RUN set -x \
#    && apt-get update \
#    && apt-get install -y \
#        xvfb \
#        google-chrome-stable \
#    && rm -rf /var/lib/apt/lists/*

#ADD scripts/xvfb-chrome /usr/bin/xvfb-chrome
#RUN ln -sf /usr/bin/xvfb-chrome /usr/bin/google-chrome

#ENV CHROME_BIN /usr/bin/google-chrome