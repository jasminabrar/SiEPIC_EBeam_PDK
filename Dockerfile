FROM quay.io/centos/centos:stream8

# Update the system and install necessary tools.
RUN dnf -y update && \
    dnf -y install wget bzip2 unzip git mesa-dri-drivers python3 python3-pip libgit2 ruby

# Find and download the latest version of KLayout for CentOS 8.
RUN curl -s https://www.klayout.de/build.html > /tmp/build_page_content.txt && \
    KLAYOUT_VERSION=$(cat /tmp/build_page_content.txt | grep -oP 'CentOS_8.*?klayout-([\d.]+)-0\.x86_64\.rpm' | grep -oP '\d+\.\d+\.\d+' | head -n 1) && \
    KLAYOUT_URL="https://www.klayout.org/downloads/CentOS_8/klayout-${KLAYOUT_VERSION}-0.x86_64.rpm" && \
    wget "$KLAYOUT_URL" -O ~/klayout.rpm && \
    dnf -y localinstall ~/klayout.rpm && \
    rm ~/klayout.rpm 

# Clone SiEPIC-Tools and SiEPIC_EBeam_PDK.
RUN mkdir -p /root/.klayout/salt && \
    cd /root/.klayout/salt && \
    git clone https://github.com/SiEPIC/SiEPIC-Tools.git && \
    git clone https://github.com/SiEPIC/SiEPIC_EBeam_PDK.git

# Set the working directory
WORKDIR /home

# Set PATH
ENV PATH="/usr/local/bin:${PATH}:/usr/local/bin/python3:/root/.local/bin"
ENV QT_QPA_PLATFORM=minimal