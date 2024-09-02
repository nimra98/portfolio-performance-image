# Pull base image.
FROM jlesage/baseimage-gui:debian-12-v4

ARG VERSION=0.70.3
ENV ARCHIVE=https://github.com/buchen/portfolio/releases/download/${VERSION}/PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz
ENV APP_ICON_URL=https://www.portfolio-performance.info/images/logo.png
	
	
RUN apt-get update && apt-get install -y wget && \
	cd /opt && wget ${ARCHIVE} && tar xvzf PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz && \
	rm PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz

# Install dependencies.
RUN \
    apt-get install -y \
        openjdk-17-jre \
        libwebkit2gtk-4.1-0 \
        firefox-esr

RUN \
    # Write config entry for new data folder, cause otherwise pp would try to write in /dev which is not possible
    echo "-data\n/config/portfolio\n$(cat /opt/portfolio/PortfolioPerformance.ini)" > /opt/portfolio/PortfolioPerformance.ini && \
	# Set initial language to english
    echo "osgi.nl=en" >> /opt/portfolio/configuration/config.ini && \
	chmod -R 777 /opt/portfolio && \
    install_app_icon.sh "$APP_ICON_URL"

# Copy the start script.
COPY rootfs/ /

# Set the name of the application.
ENV APP_NAME="Portfolio Performance"

RUN \
apt-get update && apt-get install -y \
        xfce4 \
        xfce4-terminal

# RUN export DISPLAY=localhost:0.0
RUN export DISPLAY=:0

# Create a default Firefox profile
RUN mkdir -p /root/.mozilla/firefox && \
    firefox -CreateProfile "default /root/.mozilla/firefox/default" -headless