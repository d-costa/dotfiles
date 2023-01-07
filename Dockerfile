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
RUN git config --global user.name "name"
RUN git config --global user.email "email"
RUN git add afile
RUN git commit -m "msg"
