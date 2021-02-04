resource "null_resource" "copy_to_tom" {
  provisioner "local-exec" {
    command = "sudo su | cp /var/lib/jenkins/workspace/vib_assign/target/spring-mvc-example.war /opt/tomcat/tomcat9/webapps/spring-mvc-example.war"
    //interpreter = ["PowerShell", "-Command"]
  }
}
