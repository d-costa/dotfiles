FROM ubuntu:latest
RUN useradd david
USER david
COPY . /home/david
