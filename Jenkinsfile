def unique_id = BUILD_TAG+UUID.randomUUID().toString()
//def enable_aws='0'
pipeline
{
    agent any
    environment
	{
		response_code='0'
	}
    stages 
	{
	stage('Generate UUID')
	    {
		steps
		    {
			echo 'Writing UUID to version.html'
                	uuid_write(unique_id)
			echo '[SUCCESS]UUID written'  
            	    }
	    }
        stage('Maven install')
	    {
            	steps
		    {
                	sh 'mvn clean install -DskipTests'
            	    }
	    }
        stage('[TERRAFORM]Deploy Docker Tomcat container')
	    {
            steps
		{
                /*bat """docker kill Deploy2
                        docker build . -t test2
                        docker run --rm -d -p 90:8080 --name Deploy2 test2"""*/
		sh 'terraform apply -target=module.deploy_dock -auto-approve'
		sleep time: 2500, unit: 'MILLISECONDS'
            	}	
	    }
	 stage ('[TEST]Deployment')
	    {
		 steps
		    {
			 echo 'Testing for HTTP response'
		 	script
			    {
    				response_code = sh(script: 'curl --write-out %%{http_code} --silent --location --output /dev/null http://localhost:9095/spring-mvc-example/pages/version.html', returnStdout: true)
			 	if(response_code =='200')
				    {
					    def temp=sh(script: 'curl --silent --location http://localhost:9095/spring-mvc-example/pages/version.html', returnStdout: true)
					    if(uuid_verify(temp,unique_id)) echo '[SUCCESS] Latest version deployed!'
					    else echo '[ERROR] Old version found!'
			 	//echo '[SUCCESS] Test Passed!'
				    }
	    			else echo '[ERROR] Application deployment was unsuccesful!'
        		    }
		    }
	     }
	stage ('[TEST]Automated Test')
	    {
		 steps
		    {
			 sh '''mvn test'''
		    }
	     }
	/*stage('AWS Deployment')
			{
				steps
				{
				echo 'AWS Block initiated'
				script
				{
				sleep time: 1500, unit: 'MILLISECONDS'
				if(enable_aws == '1')
				{
				bat '''cd C:/Users/Vibhor/Desktop/terra
					terraform apply -auto-approve
					terraform output'''
				}
				else echo 'AWS Deployment Off'
				}
				}
			}*/
		stage('[TERRAFORM]Deploy to Tomcat')
			{
				steps
				{
				sh 'terraform apply -target=module.deploy_tomcat -auto-approve'
				}
			}
	}
	post 
	{
        	always
		{
			echo '[PIPELINE] This will always run once steps are completed.'
			sh 'terraform destroy -auto-approve'
       		 }
       		success
		{
            		echo '[PIPELINE] This will run only if successful\n Access the App from http://localhost:90/spring-mvc-example/'
        	}
        	failure
		{
			echo '[PIPELINE] This will run only if there is failure HTTP_RESPONSE: '+ response_code
        	}
        	unstable 
		{
            		echo '[PIPELINE] This will run only if the run was marked as unstable HTTP_RESPONSE: '+ response_code
        	}
        	changed 
		{
           		echo '[PIPELINE] This will run only if the state of the Pipeline has changed HTTP_RESPONSE: '+ response_code
            		echo 'For example, if the Pipeline was previously failing but is now successful'
        	}
    	}
}
/*def Debug()
	{
		echo 'DEBUG'
	}*/
def uuid_write(String unique_id)
{//def unique_id = UUID.randomUUID().toString()
	def file = new File('/var/lib/jenkins/workspace/vib_assign/WebContent/WEB-INF/pages/version.html')
//Parse it with XmlSlurper
	def xml = new XmlSlurper().parse(file)
//Update the node value using replaceBody
//xml.tag1[0].replaceBody 'success'
	xml.tag1.replaceBody ''+unique_id
//tag1.replaceBody 'success'
//tag1[0].replaceBody 'success'
//Create the update xml string
	def updatedXml = groovy.xml.XmlUtil.serialize(xml)
//Write the content back
	file.write(updatedXml)
	echo 'UUID Written to file: '+unique_id
/*echo 'Time to read and verify'

xml = new XmlSlurper().parse(file)
def var1=xml.tag1.text()
assert xml.tag1.text() == ''+unique_id : 'Failed call'
echo 'file '+var1
echo 'works'*/
    
   // def varx=bat(script:"@curl --silent --location http://localhost:90/spring-mvc-example/pages/version.html", returnStdout: true)
   // return varx
    
}

Boolean uuid_verify(String var, String unique_id)
{
   	def xml = new XmlSlurper().parseText(var)
	def var3=xml.tag1.text()
	echo '[VERIFY] UUID value: '+var3
	echo '[VERIFY] Expected Value: '+unique_id
	assert xml.tag1.text() == ''+unique_id : 'Failed verify'
	return true
}
/*String uui_val()
{
	def t=(''+BUILD_TAG+''+UUID.randomUUID().toString())
	echo 'UUID VaL:' +t
	return (''+BUILD_TAG+''+UUID.randomUUID().toString())
}*/
