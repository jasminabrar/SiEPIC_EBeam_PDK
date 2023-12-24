FROM quay.io/centos/centos:stream8

# Update the system and install necessary tools.
RUN dnf -y update && \
    dnf -y install wget bzip2 unzip git mesa-dri-drivers python3 python3-pip

# Get the latest version of KLayout from the website
RUN curl -s https://www.klayout.de/build.html \
    | grep -oP 'CentOS 8.*?klayout-\d+\.\d+\.\d+-0.x86_64.rpm' \
    | head -n 1 \
    | ( read -r klayout_url && \
        klayout_url="https://www.klayout.de/$klayout_url" && \
        echo "Downloading KLayout from $klayout_url" && \
        curl -O $klayout_url && \
        dnf -y localinstall klayout-*.rpm && \
        rm klayout-*.rpm \
      ) || echo "Failed to retrieve KLayout URL"

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
