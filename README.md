# CentosStreamupgrade

# upgrade stream 8 to 9

yum install git -y

git clone https://github.com/PeterOosterom/CentosStreamupgrade

cd CentosStreamupgrade

chmod +x upgradestream8to9.sh

./upgradestream8to9.sh

In a second window run tail -f /var/log/messages

# Warning

Quite unstable and very janky. Not to be used in a production enviroment

Sucky sucky


https://groups.google.com/g/ansible-project/c/LFQPk-8OU1Q 
