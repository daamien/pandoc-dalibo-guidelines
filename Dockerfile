FROM python:3

COPY . /tmp

WORKDIR /tmp 

# Set the env variables to non-interactive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

# install latex packages
RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
    pandoc

RUN pip install pandoc-dalibo-guidelines

RUN pandoc --filter ./pandoc_dalibo_guidelines.py ./pandoc_dalibo_guidelines.sample.md -o ./pandoc_dalibo_guidelines.sample.json
