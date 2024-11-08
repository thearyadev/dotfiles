alias k='kubecolor' 
alias kgp='kubecolor get pods'
alias kgpw='kubecolor get pods -o wide'
alias kgnw='kubecolor get nodes -o wide'
alias ke='kubecolor get events'
alias kn='kubecolor config set-context --current --namespace'
alias ka='kubecolor apply -f'


compdef kubecolor=kubectl
