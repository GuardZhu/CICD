//定义git全局凭证ID
//def git_auth = "58f91f2d-7e9b-4fb8-903b-24464304e642"

//def git_auth = "32bde4ac-665b-4cfc-89b3-71a30f175a96"
def git_auth = "a33bba29-15dc-44c8-9ad2-5498e9df8618"

//git的url地址
def git_url = "https://gitee.com/zzwcn/cicd.git"

//定义tag
def tag = "1.0"
// 定义Harbor的URL地址
// def harbor_url = "172.16.1.138:8088"
// def harbor_project = "test-gp-yw"
//def harbor_url = "172.16.1.211:80"
// 镜像库项目名称
//def harbor_project = "test"


 def harbor_url = "172.16.4.113:8070"
 def harbor_project = "test_cicd"


def username = "admin"
//def password = "Finstone.831660"
def password = "123456"
def project_name = "cicd"

node {
    stage('拉取代码') {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: "${git_auth}", url: "${git_url}"]]])
    }
//     stage('代码审查') {
//         //定义当前Jenkins的SonarQubeScanner工具的环境
//         def scannerHome = tool 'sonarqube-scanner'
//         //引用当前Jenkins的SonarQube环境
//         withSonarQubeEnv('sonarqube-8.6.0') {
//           sh """
//                cd ${project_name}
//                ${scannerHome}/bin/sonar-scanner
//           """
//         }
//     }
    //如果有公共子工程
//     stage('编译，安装公共的子工程') {
//        sh "mvn -f jenkinscloud-common clean install"
//     }
    stage('编译，打包工程--') {
       // dockerfile:build 可以触发插件的执行
//        sh "mvn -f ${project_name} clean install dockerfile:build "
        // 编译打包开始
        sh "mvn clean package -Dmaven.test.skip=true dockerfile:build "
    }

    stage('上传镜像') {
       //定义镜像的名称
       def imageName = "${project_name}:${tag}"
       //给镜像打上标签
       sh "docker tag ${imageName} ${harbor_url}/${harbor_project}/${imageName}"
       sh "echo '给镜像打上标签'"

       //把镜像推送到Harbor, 流水线语法，选withCredentials——Username and password (separated)——输入harbor全局凭证ID
       //withCredentials([usernamePassword(credentialsId: '1a76ad5e-38f6-43ee-bce6-7473dbf77157', passwordVariable: 'Qaz7890-poi', usernameVariable: 'zhuzw')]) {
       //公司测试
       //withCredentials([usernamePassword(credentialsId: 'c7a7540d-519c-4089-a135-9254a6705a0e', passwordVariable: 'Finstone.831660', usernameVariable: 'admin')]) {
       //1.211
       //withCredentials([usernamePassword(credentialsId: 'b22e20b0-eb6c-49d6-9218-9eb581891dc4', passwordVariable: '123456', usernameVariable: 'admin')]) {
       //4.113
       withCredentials([usernamePassword(credentialsId: 'f39d2cd3-30fd-492c-8f89-dad97d90756a', passwordVariable: '123456', usernameVariable: 'admin')]) {
           // 登录到Harbor
           sh "docker login -u ${username} -p ${password} ${harbor_url}"
           //镜像的上传
           sh "docker push ${harbor_url}/${harbor_project}/${imageName}"

           sh "echo '镜像上传到Harbor仓库中成功'"
       }

    }
}