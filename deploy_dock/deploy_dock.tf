terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 1.0"
    }
  }
}
provider "docker" {
//host    = "npipe:////.//pipe//docker_engine"
}

resource "docker_container" "tomcat" {
  name  = "tom_test"
  image = docker_image.tomcat.latest
  must_run = true
  ports {
      internal = 8080
      external = 9095
  }
  /*volumes {
    //host_path = "C:/Users/Vibhor/Desktop/Assign2/target/"
    host_path="/target"
    container_path = "/usr/local/tomcat/webapps/"
  }*/
  mounts {
    //host_path = "C:/Users/Vibhor/Desktop/Assign2/target/"
    type = "bind"
    source="/var/lib/jenkins/workspace/vib_assign/target/spring-mvc-example.war"
    target = "/usr/local/tomcat/webapps/spring-mvc-example.war"
  }
}

# Find the latest Ubuntu precise image.
resource "docker_image" "tomcat" {
  name = "vbkr1598/tomcat:fix1"
  /*build {
      path = "./"/tmp/apache-tomcat-9.0.41/webapps/ROOT
     // dockerfile = "" /var/lib/jenkins/workspace
  }*/
}