# Use an official Ubuntu runtime as a parent image
FROM ubuntu:22.04

# Set environment variables
ENV ENERGI_VERSION=1.1.7
ENV ENERGI_CHECKSUM="63512d132fd80cae9d280541fec8033665dd98a9a8d2e4ff89764e4ea1987554"
ENV ENERGI_ENV=production

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    libusb-1.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m energiuser

# Set working directory
WORKDIR /home/energiuser

# Download Energi Core Node
RUN wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/v${ENERGI_VERSION}/energi3-v${ENERGI_VERSION}-linux-amd64.tgz

# Verify checksum
RUN echo "${ENERGI_CHECKSUM} energi3-v${ENERGI_VERSION}-linux-amd64.tgz" | sha256sum -c

# Extract the archive
RUN tar --strip-components=1 -xvzf energi3-v${ENERGI_VERSION}-linux-amd64.tgz

# Clean up
RUN rm energi3-v${ENERGI_VERSION}-linux-amd64.tgz

# Set ownership to energiuser
RUN chown -R energiuser:energiuser /home/energiuser

# Switch to non-root user
USER energiuser

# Expose necessary ports (adjust as needed)
EXPOSE 39796 39795

# Set the working directory to where energi3 is located
WORKDIR /home/energiuser/bin

# Run Energi Node
CMD ["./energi3", "--nousb"]