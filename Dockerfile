# Get latest Jenkins weekly from offical jenkins docker
FROM jenkins:weekly

USER root

# Install Oracle Java 7
ENV DEBIAN_FRONTEND noninteractive

RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list && \
  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
  apt-get update && \
  apt-get install -y -t precise oracle-java7-installer oracle-java7-set-default && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk7-installer
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle


# Install Google Cloud SDK

RUN apt-get update && apt-get install -y -qq --no-install-recommends wget unzip python openssh-client && apt-get clean
RUN wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip
RUN google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --disable-installation-options
RUN yes | google-cloud-sdk/bin/gcloud components update preview pkg-go pkg-python pkg-java
RUN mkdir /.ssh
ENV PATH /google-cloud-sdk/bin:$PATH
# VOLUME ["/.config"]


# Install Jenkins Plugins
RUN mkdir -p /tmp/WEB-INF/plugins && \
  curl -L https://updates.jenkins-ci.org/latest/scm-api.hpi -o /tmp/WEB-INF/plugins/scm-api.hpi && \
  curl -L http://updates.jenkins-ci.org/latest/credentials.hpi -o /tmp/WEB-INF/plugins/credentials.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/parameterized-trigger.hpi -o /tmp/WEB-INF/plugins/parameterized-trigger.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/mailer.hpi -o /tmp/WEB-INF/plugins/mailer.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/git.hpi -o /tmp/WEB-INF/plugins/git.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/git-client.hpi -o /tmp/WEB-INF/plugins/git-client.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/build-flow-plugin.hpi -o /tmp/WEB-INF/plugins/build-flow-plugin.hpi &&\
  curl -L https://updates.jenkins-ci.org/latest/envinject.hpi -o /tmp/WEB-INF/plugins/envinject.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/maven-plugin.hpi -o /tmp/WEB-INF/plugins/maven-plugin.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/github.hpi -o /tmp/WEB-INF/plugins/github.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/github-api.hpi -o /tmp/WEB-INF/plugins/github-api.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/ghprb.hpi -o /tmp/WEB-INF/plugins/ghprb.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/ssh-credentials.hpi -o /tmp/WEB-INF/plugins/ssh-credentials.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/ssh-agent.hpi -o /tmp/WEB-INF/plugins/ssh-agent.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/ssh-credentials.hpi -o /tmp/WEB-INF/plugins/ssh-credentials.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/ssh-slaves.hpi -o /tmp/WEB-INF/plugins/ssh-slaves.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/analysis-core.hpi -o /tmp/WEB-INF/plugins/analysis-core.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/analysis-collector.hpi -o /tmp/WEB-INF/plugins/analysis-collector.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/performance.hpi -o /tmp/WEB-INF/plugins/performance.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/checkstyle.hpi -o /tmp/WEB-INF/plugins/checkstyle.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/emma.hpi -o /tmp/WEB-INF/plugins/emma.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/jshint-checkstyle.hpi -o /tmp/WEB-INF/plugins/jshint-checkstyle.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/pmd.hpi -o /tmp/WEB-INF/plugins/pmd.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/findbugs.hpi -o /tmp/WEB-INF/plugins/findbugs.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/dry.hpi -o /tmp/WEB-INF/plugins/dry.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/warnings.hpi -o /tmp/WEB-INF/plugins/warnings.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/tasks.hpi -o /tmp/WEB-INF/plugins/tasks.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/embeddable-build-status.hpi -o /tmp/WEB-INF/plugins/embeddable-build-status.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/jobConfigHistory.hpi -o /tmp/WEB-INF/plugins/jobConfigHistory.hpi && \
  curl -L https://updates.jenkins-ci.org/latest/disk-usage.hpi -o /tmp/WEB-INF/plugins/disk-usage.hpi && \
  cd /tmp && zip -r /usr/share/jenkins/jenkins.war WEB-INF/* && rm -rf /tmp/WEB-INF && \
  zip -d /usr/share/jenkins/jenkins.war META-INF/JENKINS.SF && \
  zip -d /usr/share/jenkins/jenkins.war META-INF/JENKINS.RSA && \
  mkdir META-INF && unzip -p /usr/share/jenkins/jenkins.war META-INF/MANIFEST.MF > META-INF/MANIFEST.MF && \
  sed -i".bak" '10,$d' META-INF/MANIFEST.MF && \
  zip -r /usr/share/jenkins/jenkins.war META-INF/* && rm -rf META-INF/*

USER jenkins

# If you like to provide feedback on how to improve this image,
# please open an issue or a pull request for discussion!