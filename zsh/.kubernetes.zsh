alias k='kubecolor' 
alias kgp='kubecolor get pods'
alias kgpw='kubecolor get pods -o wide'
alias kgpww='kubecolor get pods -o wide --watch'
alias kgnw='kubecolor get nodes -o wide'
alias ke='kubecolor get events'
alias kn='kubecolor config set-context --current --namespace'
alias ka='kubecolor apply -f'
alias kd='kubecolor delete -f'
alias ke='kubecolor events'
alias kew='kubecolor events --watch'



compdef kubecolor=kubectl
