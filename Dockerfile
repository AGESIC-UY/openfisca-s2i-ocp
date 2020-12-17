# openfisca-backend
FROM python:3.7.5-alpine3.9

# TODO: Set the default port for applications built using this image
EXPOSE 5000

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Builder Image for Openfisca Framework based on Pyhton" \
      io.k8s.display-name="Openfisca Framework backend Buildder Image" \
      io.openshift.expose-services="5000:http" \
      io.openshift.tags="openfisca,python,alpine,36" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      maintainer="Franklin Gómez Otero <fgomezotero@gmail.com>"

ENV APP_ROOT=/opt/app-root
# Adding openfisca script path to $PATH
ENV PATH=$APP_ROOT/.local/bin/:$PATH


# TODO: Install required packages here:
RUN apk --no-cache update && \
    apk add --no-cache git make gcc musl-dev linux-headers python3-dev libstdc++ g++ bash

# Install the requiered libraries for python
RUN pip install -I --no-cache-dir pip numpy pyyaml

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# Defining the work directory
WORKDIR ${APP_ROOT}

# Adding the Openfisca user to the images
RUN adduser -D -u 1001 -G root -h ${APP_ROOT} openfisca

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:0 ${APP_ROOT} /usr/libexec/s2i && \
    chmod u+x /usr/libexec/s2i/*  && \
    chmod -R g=u ${APP_ROOT} /usr/libexec/s2i && \
    chmod g=u /etc/passwd

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]