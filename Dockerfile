FROM centos:7



# Copy in your requirements file

COPY requirements.txt /requirements.txt



RUN set -ex \

    && yum install -y --setopt=tsflags=nodocs --setopt=skip_missing_names_on_install=False epel-release yum-utils unixODBC unixODBC-devel  \

    && BUILD_DEPS=" \

        gcc \

        gcc-c++ \

        python-devel \

        kernel-devel \

        make \

        postgresql-devel \

        python-pip \

    " \

    && yum update -y && yum install -y --setopt=tsflags=nodocs --setopt=skip_missing_names_on_install=False $BUILD_DEPS



ENV VIRTUAL_ENV=/venv



RUN pip install --upgrade pip \

    && pip install virtualenv \

    && virtualenv $VIRTUAL_ENV \

    && $VIRTUAL_ENV/bin/pip install -U pip \

    && $VIRTUAL_ENV/bin/pip install --no-cache-dir -r /requirements.txt



RUN set -ex \

    && BUILD_DEPS=" \

        gcc \

        gcc-c++ \

        python-devel \

        kernel-devel \

        make \

        postgresql-devel \

        python-pip \

    " \

    && yum remove -y $BUILD_DEPS \

    && yum clean all





# Copy your application code to the container (make sure you create a .dockerignore file if any large files or directories should be excluded)

RUN mkdir -p /code/

WORKDIR /code/

ADD . /code/



# uWSGI will listen on this port

EXPOSE 8000



# Add any static environment variables needed by Django or your settings file here:

ENV DJANGO_SETTINGS_MODULE=project2.settings



# Tell uWSGI where to find your wsgi file (change this):

ENV UWSGI_WSGI_FILE=/code/project2/wsgi.py



# Base uWSGI configuration (you shouldn't need to change these):

ENV UWSGI_HTTP=:8000 UWSGI_MASTER=1 UWSGI_HTTP_AUTO_CHUNKED=1 UWSGI_HTTP_KEEPALIVE=1 UWSGI_LAZY_APPS=1 UWSGI_WSGI_ENV_BEHAVIOR=holy



# Number of uWSGI workers and threads per worker (customize as needed):

ENV UWSGI_WORKERS=2 UWSGI_THREADS=4



# to run any sub-process from virtualenv

ENV PATH="$VIRTUAL_ENV/bin:$PATH"



# Start uWSGI

CMD ["uwsgi", "--show-config"]
