#check if session daywork exist

tmux has-session -t daywork

if [ $? != 0 ]
then

	# start a session&window: daywork:status 
	# for shadowsocks and top command
	tmux new -s daywork -n status -d
	tmux send-keys -t daywork 'cd app && ./ss.sh' C-m
	tmux split-window -h -t daywork:status
	tmux send-keys -t daywork:status.1 'top' C-m

	# start a window daywork:demlution  
	# for git pull, runserver, npm run dmhome, gulp
	tmux new-window -n demlution -t daywork
	tmux send-keys -t daywork:demlution 'atom demlution/bazaar4' C-m
	tmux send-keys -t daywork:demlution 'cd demlution/bazaar4 && git checkout master' C-m
	tmux send-keys -t daywork:demlution 'git pull demlution master' C-m
	tmux split-window -h -t daywork:demlution
	tmux send-keys -t daywork:demlution.1 'cd demlution/bazaar4 && workon demlution && python -Wi manage.py runserver' C-m
	tmux split-window -v -p 30 -t daywork:demlution
	tmux send-keys -t daywork:demlution.2 'cd demlution/bazaar4 && npm run dmhome' C-m
	tmux split-window -h -t daywork:demlution
	tmux send-keys -t daywork:demlution.3 'cd demlution/bazaar4 && gulp' C-m

	#start a window daywork:shell
	tmux new-window -n shell -t daywork
	tmux send-keys -t daywork:shell 'cd demlution/bazaar4 && workon demlution' C-m
	tmux send-keys -t daywork:shell 'python -Wi manage.py shell' C-m

	#start a window daywork:psql
	tmux new-window -n psql -t daywork
	tmux send-keys -t daywork:psql 'psql -U postgres' C-m
	tmux send-keys -t daywork:psql '\c bazaar4_13' C-m

fi


tmux attach -t daywork:demlution.0

