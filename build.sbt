name := "DL4J playground"

version := "0.1"

classpathTypes += "maven-plugin"

libraryDependencies ++= Seq(
  "org.deeplearning4j" % "deeplearning4j-cuda-8.0" % "0.7.3-SNAPSHOT" changing(),
  "org.deeplearning4j" % "deeplearning4j-modelimport" % "0.7.3-SNAPSHOT" changing(),
  "org.slf4j" % "slf4j-simple" % "1.7.22",
  "org.nd4j" % "nd4j-cuda-8.0" % "0.7.3-SNAPSHOT" classifier "",
  "org.nd4j" % "nd4j-cuda-8.0" % "0.7.3-SNAPSHOT" classifier "linux-x86_64"
)

resolvers += Resolver.mavenLocal

scalaVersion := "2.11.7"

fork := true

javaOptions += "-Xmx4G"
