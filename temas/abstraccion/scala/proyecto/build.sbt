name := "proyecto"

version := "0.1"

scalaVersion := "3.4.1"

// Agregar dependencias del proyecto
libraryDependencies ++= Seq(
  "org.typelevel" %% "cats-core" % "2.7.0",
  "org.scalatest" %% "scalatest" % "3.2.10" % Test
)

