#!/bin/bash
SESSION=sldev

cd $HOME/dev/repo/savelend/loansys.react.web

tmux new-session -d -s $SESSION
tmux select-window -t $SESSOION:1
tmux send-keys 'nvim' C-m

tmux new-window -t $SESSION:2 -n 'tests'
tmux select-window -t $SESSOION:2
tmux send-keys 'npm run test:watch' C-m

tmux new-window -t $SESSION:3 -n 'webpack ls'
tmux select-window -t $SESSOION:3
tmux send-keys 'npm run loanstep-dev' C-m


tmux new-window -t $SESSION:4 -n 'webpack sl'
tmux select-window -t $SESSOION:4
tmux send-keys 'npm run savelend-dev' C-m

tmux select-window -t $SESSION:1

tmux attach -t $SESSION
