#Java-maven-Git-Tomcat-Jenkins Configuration

#login to root
echo login to root
sudo -i

#install wget downloaded.
echo install wget downloaded.
 yum install wget -y

#===========================JAVA INSTALLATION START==========================================

#JAVA Setup
echo JAVA Setup
#download JDK rpm
echo download JDK rpm
wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.rpm
#Install RPM
echo Install RPM
rpm -i jdk-8u191-linux-x64.rpm

#Setup Maven
export JAVA_HOME=/usr/java/jdk1.8.0_191-amd64

export PATH=$JAVA_HOME/bin:$PATH

#Check java
echo Check the java version
java -version

#Java Home path: /usr/java/jdk1.8.0_131
echo Java Home path: /usr/java/jdk1.8.0_191-amd64

#===========================JAVA INSTALLATION END=========================================

#===========================MAVEN SETUP START========================================================

#Maven Setup:
echo Maven Setup:
#Download maven:
echo Download maven:
 wget http://mirror.cogentco.com/pub/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz

#Unzip tar file
echo Unzip tar file
 tar zxpvf apache-maven-3.5.4-bin.tar.gz

#maven home path depedns on the user: here we are running from root user. /home/ec2-user/apache-maven-3.5.4
echo maven home: /root/apache-maven-3.5.4

#Setup Maven
export MAVEN_HOME=/root/apache-maven-3.5.4

export M3=$MAVEN_HOME/bin

export PATH=$M3:$PATH

#check maven: mvn -v
echo check maven: mvn -v
mvn -v

#vi /root/apache-maven-3.5.4/conf/settings.xml: update this settings file with below nexus credentials.
echo'
	<server>
		<id>deployment</id>
		<username>deployment</username>
		<password>deployment123</password>
	</server>
'

#===========================MAVEN SETUP END========================================================

#===========================TOMCAT SETUP START========================================================

#Tomcat Setup:
echo Tomcat Setup:
#Download Tomcat
echo Download Tomcat
wget http://ftp.cixug.es/apache/tomcat/tomcat-7/v7.0.92/bin/apache-tomcat-7.0.92.tar.gz

#Unzip tar file
echo Unzip tar file
tar zxpvf apache-tomcat-7.0.92.tar.gz

#Move to folder
echo Move to folder
mv apache-tomcat-7.0.92 tomcat7

#Update tomcat-users.xml file: vi tomcat7/conf/tomcat-users.xml
echo'
<role rolename="manager-gui"/>
<user username="tomcat" password="s3cret" roles="manager-gui"/>
'

#Check whether its updated properly or not: cat tomcat7/conf/tomcat-users.xml

#Startup the server: ./tomcat7/bin/startup.sh
#Shutdown the server: ./tomcat7/bin/shutdown.sh

#Startup the tomcat server and then launch the URL in any browser: http://<PublicIP>:8080

#===========================TOMCAT SETUP END=================================================


#===========================JENKINS SETUP START=================================================

#Jenkins Setup:
echo Jenkins Setup:

#Download Jenkins
echo Download Jenkins
wget http://updates.jenkins-ci.org/download/war/2.135/jenkins.war

#Deploy war to tomcat
echo Deploy war to tomcat
mv jenkins.war tomcat7/webapps/

#Restart the server if required.
#/root/tomcat7/bin/shutdown.sh
#/root/tomcat7/bin/startup.sh

#launch the tomcat URL and start jenkins.
#Access the URL: http://publicIP:8080/ in browser

#Login to "Manager webapp" --> click on "jenkins" --> http://18.218.88.137:8088/jenkins/

#While Jenkins is starting up, it will ask you to enter pwd from the below location.

#Run the command: cat /root/.jenkins/secrets/initialAdminPassword

#Copy the pwd and paste it on jenkins.

#Install plugins (first option)

#Uname/pwd/email setup OR continue as admin. Recommend to signup & continue as user.

#Manage Jenkins --> Global Tool Configuration 

#--> Add JDK home path : 
#		Name: jdk1.8.0_181
#		Path: /usr/java/jdk1.8.0_181-amd64
#--> Add Git home path :  
#		Name: GitExePath
#		Path: /usr/bin/git
#--> Add Mvn home path :  
#		Name: maven-3.5.4
#		Path: /root/apache-maven-3.5.4


#===========================JENKINS SETUP END=================================================

#===========================GIT INSTALLATION START===========================================

#Git Setup:
echo Git Setup:
#Git Installation
echo Git Installation
 yum install git -y

#GitHome: /usr/bin/git  ( find  /  -name "git" -- to search with command)
echo GitHome: /usr/bin/git  ( find  /  -name "git" -- to search with command)

#Git Version
echo Git Version
git --version

java -version

mvn -v

#===========================GIT INSTALLATION END========================================================

#Note:
#Note-1: Marked with the workds "Crosscheck" & "Update" for manual actions. Search for those workds in this file and take an action accordingly.
#Note-2:Please "Crosscheck" whether those details are correct are not. Update the paths if they are different.

#Installation Procedure:
#Step-1: Copy the lines from 1 to 170, and then paste it on yout terminal. All the commands will be executed one by one.
#Step-2: Run the below commands make sure java, git, maven installed properly.
#java -version, mvn -v, git --version
#Step-3: Run this command, jenkins.war should be there: ll tomcat7/webapps/
#Step-4: Take care of manual actions from line number 90 to 101. (if you have any doubts, go to the section "Tomcat Start-up" in the end of the pages in AWS-TOMCAT-JENKINS.doc)
#Step-5: Take care of manual actions from line number 119 to 148 (if you have any doubts, go to the section "Jenkins Start-up" in the middle of the pages in AWS-TOMCAT-JENKINS.doc).
