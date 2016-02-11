echo Installing packages
        # For elasticsearch
      sudo apt-get update
      sudo dpkg -i /vagrant/elasticsearch-0.90.7.deb

      # This will install later versions. War and POM need to be updated accordingly, add elasticsearch to apt-get install below
      #wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
      #sudo bash -c "echo deb http://packages.elasticsearch.org/elasticsearch/1.2/debian stable main >> /etc/apt/sources.list"

      # For yeoman / angular
      sudo add-apt-repository ppa:chris-lea/node.js -y

      sudo apt-get update
      sudo bash -c "DEBIAN_FRONTEND=noninteractive apt-get install -y python-software-properties python g++ make nodejs  mysql-server-5.6 phantomjs"

      # We don't need these memory hogs while we setup, we'll turn them on later
      sudo service mysql stop
      sudo service tomcat7 stop

      # Increase tomcat memory
      #sudo bash -c 'echo -e "\n# From Vagrantfile\nJAVA_OPTS=\"-Xmx2g\"\n" >> /etc/default/tomcat7'

      echo Buliding and Installing Metadata Webapp

      # Use the local DB
      sudo bash -c "echo 'database.host=localhost' > ~tomcat7/ti_metadata.properties"
      sudo bash -c "echo 'database.password=metaserver' >> ~tomcat7/ti_metadata.properties"

      # Prereqs for metadata
      cd /vagrant/metadata
      sudo npm install -g yo grunt bower generator-angular
      sudo npm install -g grunt-cli
      sudo apt-get install -y ruby-dev
      sudo gem install compass
      #sudo rm -rf /var/lib/tomcat7/webapps/ROOT
         echo "INSTALLING JAVA 8 AS USER `whoami` "

        echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" |sudo  tee /etc/apt/sources.list.d/webupd8team-java.list
        echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" |sudo  tee -a /etc/apt/sources.list.d/webupd8team-java.list

        # Accept license non-iteractive
        echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
        sudo apt-get update
        sudo apt-get install -y oracle-java8-installer

    # Make sure Java 8 becomes default java
     sudo apt-get install -y oracle-java8-set-default

    # exit
      sudo apt-get purge maven
      sudo apt-add-repository ppa:andrei-pozolotin/maven3
      sudo apt-get update
      sudo apt-get install maven3 -y
      sudo apt-get install git -y

      mvn install:install-file -Dfile=/vagrant/sqljdbc42.jar -DgroupId=com.microsoft.sqlserver -DartifactId=sqljdbc4 -Dversion=4.2 -Dpackaging=jar
      #nice mvn clean install -DskipTests=true && sudo cp target/metadata.war /var/lib/tomcat7/webapps/ROOT.war

      echo Final preparations for metadata
      sudo ln -s /vagrant/src/test/resources/mas90.accdb /var/mas90.accdb
      sudo mkdir -p /var/product_images

      #sudo chown tomcat7:tomcat7 /var/product_images
      #sudo usermod -aG tomcat7 vagrant
      #sudo ln -s /var/log/tomcat7/catalina.out ~/tomcat7.log

      sudo service elasticsearch restart
      sudo service mysql start
      #sudo service tomcat7 start

      sleep 10 # Elasticsearch can take a bit to start
      bash /vagrant/create_index.sh

      mysql -u root -e "CREATE DATABASE IF NOT EXISTS metadata;"
      mysql -u root -e "GRANT ALL PRIVILEGES ON metadata.* TO metaserver@'%' IDENTIFIED BY 'metaserver'; FLUSH PRIVILEGES;"
      mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO root@'192.168.42.1'; FLUSH PRIVILEGES;"

      bzcat /vagrant/metadata-201601211417.sql.bz2 | mysql -u metaserver -pmetaserver metadata
      cd  /vagrant/ && mvn clean package -DskipTests -DbuildNumber=stage
      nohup java -jar /vagrant/target/metadata-stage.jar &
