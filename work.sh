sw() {
	{
		echo "NEW WORK"
		echo "$PWD"
		fc -ln -8
		echo "END OF NEW WORK"
	} >> ~/work
}

cw() {
	cat ~/work
}

rmw() {
	if [[ ! -f ~/work ]]; then
		echo "No work, exiting"
		return
	fi
	if [[ $(stat -c%s "$HOME/work") == 0 ]]; then
		echo "Work file is empty"
		rm ~/work
		return
	fi
	echo "!!! WARNING !!!"
	echo "Work file not empty, contents:"
	cw
	read -p "Delete work file anyway? " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "Removing work file"
		rm ~/work
		return
	fi
	echo "Leaving work file as is"
}
