#!/bin/bash
SESSION=onboarding

cd "$HOME/dev/repo/Agero/Onboarding-process/Agero.OnboardingProcess.Web.UI" || exit

tmux new-session -d -s $SESSION
tmux select-window -t "$SESSION:1"
tmux send-keys 'nvim' C-m

tmux new-window -t $SESSION:2 -n 'tests'
tmux select-window -t "$SESSION:2"
tmux send-keys 'yarn run test' C-m

tmux new-window -t $SESSION:3 -n 'server'
tmux select-window -t "$SESSION:3"
tmux send-keys 'yarn run start' C-m
tmux split-window -d

tmux select-window -t $SESSION:1

tmux attach -t $SESSION
