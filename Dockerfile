FROM adoptopenjdk:12-jdk-openj9

RUN apt-get update \
	&& apt-get install --yes --no-install-recommends \
	wget \
	unzip \
	git \
	patch \
	&& rm -rf /var/lib/apt/lists/*

ENV GRADLE_VERSION=5.6.2
ENV GRADLE_HOME=/opt/gradle

RUN wget --no-verbose --output-document gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
	&& wget --no-verbose --output-document gradle.zip.sha256 "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip.sha256" \
	&& echo "$(cat gradle.zip.sha256) gradle.zip" | sha256sum --check \
	&& unzip -q gradle.zip \
	&& mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}" \
	&& ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle \
	&& rm gradle.zip \
	&& rm gradle.zip.sha256 \
	&& gradle --version

ENV MAVEN_VERSION=3.6.2
ENV MAVEN_HOME=/opt/maven

RUN wget --no-verbose --output-document maven.zip "https://www.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.zip" \
	&& wget --no-verbose --output-document maven.zip.sha512 "https://www.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.zip.sha512" \
	&& echo "$(cat maven.zip.sha512) maven.zip" | sha512sum --check \
	&& unzip -q maven.zip \
	&& mv "apache-maven-${MAVEN_VERSION}" "${MAVEN_HOME}" \
	&& ln --symbolic "${MAVEN_HOME}/bin/mvn" /usr/bin/mvn \
	&& rm maven.zip \
	&& rm maven.zip.sha512 \
	&& mvn --version

RUN apt-get purge --yes \
	wget \
	unzip
