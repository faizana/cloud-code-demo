FROM hseeberger/scala-sbt:8u181_2.12.8_1.2.8 

WORKDIR /app

ADD project /app/project

# copy the pom.xml file to download dependencies
COPY build.sbt ./

# download dependencies as specified in build.sbt
# building dependency layer early will speed up compile time when pom is unchanged
RUN sbt update

# Copy the rest of the working directory contents into the container
COPY . ./

# Compile the application.
RUN cd /app && sbt assembly

# Starts java app with debugging server at port 50005.
CMD ["java", "-jar", "/app/target/scala-2.12/akka-http-microservice-assembly-1.0.jar"]