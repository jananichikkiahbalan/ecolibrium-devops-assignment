pipeline {
agent any

```
environment {
    AWS_REGION = 'ap-south-1'
    ECR_REPO = '425629233235.dkr.ecr.ap-south-1.amazonaws.com/ecolibrium-flask-app'
    IMAGE_TAG = 'latest'
    CLUSTER_NAME = 'ecolibrium-dev-eks'
}

stages {

    stage('Checkout Code') {
        steps {
            git branch: 'main',
            url: 'https://github.com/jananichikkiahbalan/ecolibrium-devops-assignment.git'
        }
    }

    stage('Terraform Init') {
        steps {
            dir('terraform') {
                sh 'terraform init'
            }
        }
    }

    stage('Terraform Apply') {
        steps {
            dir('terraform') {
                sh 'terraform apply -auto-approve'
            }
        }
    }

    stage('Build Docker Image') {
        steps {
            sh '''
            docker build -t $ECR_REPO:$IMAGE_TAG ./app
            '''
        }
    }

    stage('Login to Amazon ECR') {
        steps {
            sh '''
            aws ecr get-login-password --region $AWS_REGION | \
            docker login --username AWS --password-stdin 425629233235.dkr.ecr.ap-south-1.amazonaws.com
            '''
        }
    }

    stage('Push Docker Image') {
        steps {
            sh '''
            docker push $ECR_REPO:$IMAGE_TAG
            '''
        }
    }

    stage('Update kubeconfig') {
        steps {
            sh '''
            aws eks update-kubeconfig \
            --region $AWS_REGION \
            --name $CLUSTER_NAME
            '''
        }
    }

    stage('Deploy using Helm') {
        steps {
            sh '''
            cd helm/flask-app

            helm upgrade --install flask-app .
            '''
        }
    }

    stage('Verify Deployment') {
        steps {
            sh '''
            kubectl get nodes
            kubectl get pods
            kubectl get svc
            '''
        }
    }
}
```

}
