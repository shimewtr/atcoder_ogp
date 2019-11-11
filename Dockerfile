FROM ubuntu:16.04

# Install.
RUN \
    apt-get update && \
    apt-get install -y python3 wget curl unzip apt-utils && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    pip install --upgrade pip && \
    pip install selenium && \
    pip install beautifulsoup4 && \
    apt-get install -y libfontconfig && \
    mkdir -p /home/root/src && cd $_ && \
    wget -q -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ && \
    apt-get install -y libappindicator1 fonts-liberation libasound2 libnspr4 libnss3 libxss1 lsb-release xdg-utils && \
    touch /etc/default/google-chrome && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb && \
    apt-get install -y fonts-migmix

RUN apt-get install -y sudo
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade Pillow

# add sudo user
RUN groupadd -g 1000 developer && \
    useradd  -g      developer -G sudo -m -s /bin/bash rotelstift && \
    echo 'rotelstift:password' | chpasswd

RUN echo 'Defaults visiblepw'                >> /etc/sudoers
RUN echo 'rotelstift ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set japanese
RUN apt-get install -y language-pack-ja-base language-pack-ja
RUN locale-gen ja_JP.UTF-8

# Set environment variables.
ENV LANG ja_JP.UTF-8
ENV PYTHONIOENCODIND utf_8

USER rotelstift

RUN mkdir ~/python_capture
RUN mkdir ~/python_capture/docs
RUN mkdir ~/python_capture/docs/image
COPY capture_rate.py /home/rotelstift/python_capture/
WORKDIR /home/rotelstift/python_capture/
RUN python3 ./capture_rate.py
