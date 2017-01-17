name := "DL4J playground"

version := "0.1"

libraryDependencies ++= Seq(
  "org.deeplearning4j" % "deeplearning4j-cuda-8.0" % "0.7.2",
  "org.nd4j" % "nd4j-cuda-8.0-platform" % "0.7.2",
  "org.slf4j" % "slf4j-simple" % "1.7.22"
)

scalaVersion := "2.11.8"

fork := true

javaOptions += "-Xmx4G"
