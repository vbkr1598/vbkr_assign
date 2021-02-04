resource "null_resource" "copy_to_tom" {
  provisioner "local-exec" {
    command = "echo 'T9s4krwJb336' | sudo -S cp /var/lib/jenkins/workspace/vib_assign/target/spring-mvc-example.war /opt/tomcat/tomcat9/webapps/spring-mvc-example.war"
    //interpreter = ["PowerShell", "-Command"]
  }
}
