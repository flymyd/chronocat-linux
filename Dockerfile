ARG NODE_VERSION=20.11.0
FROM node:${NODE_VERSION}-bookworm AS node

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update

# Install dependencies
RUN apt install -y xfce4 xfce4-goodies x11vnc libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 xdg-utils libatspi2.0-0 libsecret-1-0 unzip libgbm1 libasound2 xvfb curl

# Install QQ
# COPY linuxqq_3.1.2-13107_amd64.deb /root
# RUN dpkg -i /root/linuxqq_3.1.2-13107_amd64.deb && rm /root/linuxqq_3.1.2-13107_amd64.deb
RUN curl -o /root/linuxqq_3.1.2-13107_amd64.deb https://dldir1.qq.com/qqfile/qq/QQNT/ad5b5393/linuxqq_3.1.2-13107_amd64.deb
RUN dpkg -i /root/linuxqq_3.1.2-13107_amd64.deb && rm /root/linuxqq_3.1.2-13107_amd64.deb


# Install LLQQ
COPY LiteLoaderQQNT.zip /tmp
RUN unzip /tmp/LiteLoaderQQNT.zip -d /opt/QQ/resources/app/ \
    && rm /tmp/LiteLoaderQQNT.zip && sed -i 's/"main": ".\/app_launcher\/index.js"/"main": ".\/LiteLoader"/' /opt/QQ/resources/app/package.json

# Install Chronocat
COPY chronocat-llqqnt.zip /tmp
RUN mkdir -p /root/LiteLoaderQQNT/plugins \
  && unzip /tmp/chronocat-llqqnt.zip -d /root/LiteLoaderQQNT/plugins/ \
  && rm /tmp/chronocat-llqqnt.zip

# Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 16340 16530
ENV DISPLAY=:1 \
    VNC_RESOLUTION=1024x768 \
    VNC_COL_DEPTH=16
COPY run.sh /
RUN chmod +x /run.sh
CMD ["/run.sh"]
