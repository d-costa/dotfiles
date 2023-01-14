FROM ubuntu:latest
RUN apt update
RUN apt install -y git
RUN useradd username
USER username

WORKDIR /home/username/dotfiles
COPY . .
RUN ./install.sh

RUN mkdir folder
WORKDIR /home/username/folder
RUN git init && touch afile
