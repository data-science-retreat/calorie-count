name := "DL4J playground"

version := "0.1"

libraryDependencies ++= Seq(
  "org.deeplearning4j" % "deeplearning4j-core" % "0.6.0",
  "org.nd4j" % "nd4j-native-platform" % "0.5.0",
  "org.slf4j" % "slf4j-api" % "1.7.22",
  "org.slf4j" % "slf4j-simple" % "1.7.22"
)

scalaVersion := "2.11.8"

classpathTypes += "maven-plugin"

