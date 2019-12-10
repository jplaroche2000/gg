# Copyright (c) 2019 TELUS Communicaiton inc. All rights reserved.
#

FROM oracle/coherence:12.2.1-3-2

MAINTAINER Jean-Philippe Laroche <jean-philippe.laroche@telus.com>

USER root

# Tools - iconfig required to grep bridge subnet provisionned IP
RUN set -eux; \
	yum install -y \
		net-tools \
		iputils \
	; \
	rm -rf /var/cache/yum

# Users and groups
RUN groupadd -g 500 ec2-user && groupadd -g 497 docker && useradd -M -g 500 -G 497 -u 500 -s /bin/bash ec2-user && usermod -a -G docker oracle

# GG home
RUN mkdir -p /u01/oracle/gg_home

# ------------------------

# Copy local files required to build this image
COPY gg_home.tar.gz /u01/oracle/gg_home
COPY start-gg.sh /u01/oracle/gg_home/start-gg.sh
COPY GLOBALS /u01/oracle/gg_home/GLOBALS
COPY dirprm /u01/oracle/gg_home/dirprm
COPY dir_coh /u01/oracle/gg_home/dir_coh

RUN  chown -R oracle:oracle /u01/oracle/gg_home &&  chmod a+rx /u01/oracle/gg_home/start-gg.sh

# -----------------------

USER oracle

# Install and configure Oracle JDK
# Setup required packages (unzip), filesystem, and oracle user
# ------------------------------------------------------------
RUN cd /u01/oracle/gg_home && tar -zxvf gg_home.tar.gz && rm /u01/oracle/gg_home/gg_home.tar.gz

WORKDIR /u01/oracle/gg_home

ENV GG_HOME=/u01/oracle/gg_home \
    LD_LIBRARY_PATH=${JAVA_HOME}/jre/lib/amd64/server:${LD_LIBRARY_PATH} 

ENTRYPOINT ["./start-gg.sh"]
