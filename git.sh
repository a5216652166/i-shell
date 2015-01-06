#http://www.centoscn.com/CentosServer/ftp/2014/0414/2789.html
#TODO:
function installGitServer(){
    yum install git -y
    yum install gitosis gitweb
    useradd --home /home/git git
    mkdir -p /home/git

}